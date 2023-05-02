Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54ED6F47F4
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 18:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjEBQH1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 12:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjEBQH0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 12:07:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7681F30FD
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 09:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122DD61198
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 16:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E671C433EF;
        Tue,  2 May 2023 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683043644;
        bh=GelsHfU1LcexQR5Yg3BUfPeGTY13e0gpyb4kYyhYKb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZU3NYaZd5KvjL5fbhAOvlkcNQgI872AT2kKdQNhK8yOsII/rOGjfKMJtw7SUbDitR
         LIPQjWZ9JtitJtlBZd4jTGYnA3vY/ImP5iZHCaIpKvfsLzLinZaKByhdMCSvfA7eHy
         4Vt9o7s9M61DHqLUnPb+cmxE1rgN9Fp7HunjpDPk7CoE4HMWIWTuQ6XFR2LFBKisml
         r2aRAsyJuMVt6Bckag6zqxskcivZb8IpPBD9iws4L50f3V2XUfiykYEdOoITJwL4px
         oqi6bKWOQTtN9tgZhIJOpDpZdE9Ej8//ZK7MWg9aTSvvNmpRNUWzNMPEjuUAL1hg80
         fLhsoh6Q7XSpQ==
Date:   Tue, 2 May 2023 11:07:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI/ASPM: Disable ASPM_STATE_L1 only when class
 driver disables L1 ASPM
Message-ID: <20230502160722.GA691169@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFEENUdnDPCvwtVS@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 02, 2023 at 06:08:13PM +0530, Ajay Agarwal wrote:
> On Mon, May 01, 2023 at 12:21:14PM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 11, 2023 at 04:40:32PM +0530, Ajay Agarwal wrote:
> > > Currently the aspm driver sets ASPM_STATE_L1 as well as
> > > ASPM_STATE_L1SS bits when the class driver disables L1.
> > 
> > I would have said just "driver" -- do you mean something different by
> > using "class driver"?  The callers I see are garden-variety drivers
> > for individual devices like hci_bcm4377, xillybus_pcie, e1000e, jme,
> > etc.
>
> No, I do not mean anything different by "class driver". I just wanted
> to name the caller drivers of the ASPM APIs as something other than
> just "driver". Do you want me to change this to "driver" ?

Yes, please, I think "driver" by itself is sufficient.  IIUC, "class
driver" generally refers to a generic or abstract driver that provides
a common interface to a variety of different devices.  This interface
could be used by such a class driver or by the driver for a specific
device, but the type of driver is not relevant to this patch.

Bjorn
