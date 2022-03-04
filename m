Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6F4CDC9F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 19:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiCDSfp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 13:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiCDSfo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 13:35:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1307F186BBF;
        Fri,  4 Mar 2022 10:34:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A251FB82B33;
        Fri,  4 Mar 2022 18:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2148C340E9;
        Fri,  4 Mar 2022 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646418893;
        bh=6OJXo+wTmMDK0HYpOgD2/ABd5hCrQTAMKWEXggBmyOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=c5BIgDgGY5+UJ8lwXu0RUuqqDY2FsV55y7zqdD81HMLJsCUFHxwLD5g2naHzJgV1v
         1MeHNrJq5YN7791I5ErtSn3+aP8kR8ELuDXVPBHVgj+P8I0TT4yBUS2RngS6m+Ubb5
         Q8s7j0Znait2ySrOM/kbEn0ixjLu7mfK0m/Pcgx+WMNF/tFrCsrzuOaNS776zsbTt0
         tijwGq75oacS+5xptb9yln2+FZnS2Rs9ipw2O3nVMPbCUEO98dJD4V/u0Z1ihSGiF7
         DoVZjXICH6IoGw2yScL7Xjvb4xVTi1GpLjPgB0qorQ1f923z4XiJ4U5vpFcO07MBSW
         ox3oWtOIlzFcA==
Date:   Fri, 4 Mar 2022 12:34:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, wse@tuxedocomputers.com
Subject: Re: [PATCH 3/3] x86/PCI: Preserve host bridge windows completely
 covered by E820
Message-ID: <20220304183451.GA1046413@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b17447-b285-f6ce-99d8-f2cad01405d5@redhat.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 04, 2022 at 04:46:11PM +0100, Hans de Goede wrote:
> On 3/4/22 16:32, Bjorn Helgaas wrote:

> > I think what might add useful information would be to always log the
> > EFI "RUN" entries.  IIUC, currently the "efi: mem47: ..." lines are
> > only emitted when booting with "efi=debug"?
> > 
> > I think the "RUN" lines indicate regions that must be virtually mapped
> > so EFI runtime services can use them, and it seems like it might be
> > more generally useful to always mention them.
> 
> I'm not sure about always logging the EFI memmap I agree it might
> be useful sometimes, but it is easy to enable then and the initial
> boot code of the kernel already is pretty "chatty".

Yeah.  I didn't mean all of the EFI memmap, just the parts that we're
sharing with firmware.  But I guess everybody probably has different
parts of the map they think would be interesting :)
