Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CEA6B84E9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 23:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCMWmk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 18:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCMWmd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 18:42:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B3C90781;
        Mon, 13 Mar 2023 15:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 924A361523;
        Mon, 13 Mar 2023 22:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE65C433EF;
        Mon, 13 Mar 2023 22:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678747347;
        bh=o+9RRoemqsFvnAj1RdtpzpNry1V+R+AF/d0DKvHxRVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oYt1JyFXtYjnJLkP9+hKdSrG6aUZ6SK954FAI7xoRfVcWNPyTeZ2JjVfA9sQ0cYlY
         1ELGa60BQRmFKaPHp+nxEOR6YaRagRmIOkTK8oJ6N5SELBVIGPZP/E8+aoLCJlhSZ6
         QI76mUZvTegkdb/paHdVZhYq0glRqHOZ+1BPipnTLeuT0Ji/NXoGSlJkCupO5B18QS
         qfLR8A4E8q9stazbYOxUAm8svbdkprcKjtSubavOGUjdjMJh4lmmXj/pNzd2mahFQu
         /Ey0tsbpEuBXoO41Q2tonuBl+otxVUlAjxZVs1OuCES/uTuxUJAiaGUYTqe7yuUHa/
         6C0FHq7EafXVQ==
Date:   Mon, 13 Mar 2023 17:42:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
Subject: Re: [PATCH v2 1/2] PCI/ATS: Add a helper function to configure ATS
 STU of a PF
Message-ID: <20230313224225.GA1551878@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6339c50a-8dfe-f3a2-63d7-504abd4e62f0@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 13, 2023 at 03:30:30PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 3/13/23 2:12 PM, Bjorn Helgaas wrote:
> > On Mon, Feb 27, 2023 at 08:21:36PM -0800, Ganapatrao Kulkarni wrote:
> >> As per PCI specification (PCI Express Base Specification Revision
> >> 6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
> >> independently for ATS capability, however the STU(Smallest Translation
> >> Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
> >> the associated PF's value applies to VFs.
> >>
> >> In the current code, the STU is being configured while enabling the PF ATS.
> >> Hence, it is not able to enable ATS for VFs, if it is not enabled on the
> >> associated PF already.
> >>
> >> Adding a function pci_ats_stu_configure(), which can be called to
> >> configure the STU during PF enumeration.
> >> Latter enumerations of VFs can successfully enable ATS independently.

> >> + * pci_ats_stu_configure - Configure STU of a PF.
> >> + * @dev: the PCI device
> >> + * @ps: the IOMMU page shift
> >> + *
> >> + * Returns 0 on success, or negative on failure.
> >> + */
> >> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
> >> +{
> >> +	u16 ctrl;
> >> +
> >> +	if (dev->ats_enabled || dev->is_virtfn)
> >> +		return 0;
> 
> We don't have any checks for the PF case here. That means you can
> re-configure the STU as many times as you want until ATS is enabled
> in PF. So, if there are active VFs which uses this STU, can PF
> re-configure the STU at will?

Really good question!  I withdraw my ack until this is resolved.

I don't think we want PFs changing STU behind the back of VFs.

Bjorn
