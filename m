Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307604F6B85
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 22:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiDFUnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 16:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiDFUmz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 16:42:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD74E3A429F
        for <linux-pci@vger.kernel.org>; Wed,  6 Apr 2022 11:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ADEEB81C83
        for <linux-pci@vger.kernel.org>; Wed,  6 Apr 2022 18:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8400AC385A5;
        Wed,  6 Apr 2022 18:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649271572;
        bh=+SU7XsziksrNuUgFgSjsRBlLvL6CDdRGbwZrfDXJctI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CjTNIwmirMJkUF66ocvXWfLTUCtuqhLpQr6/qjDeo0GpUJaqmDtfchMzly8XPY7HQ
         cQB7GWukj4NxEA78fHuxYskWn5M6PEWAQjF+/y8WgBpcad5l3upN3Wnt1IACg1fOqM
         i8zNMcM7bpmD/XoYws7HnJzvL49wqBlEaBIV9gxEFZ1e+2i1X+0hYZihcOzpxczMNW
         xZDAK0hkyT7G/YOXqfGnwE+ja6/bwm0eJrbUvL2t8BHm5qYDlXJ5iXtu3Ig97HoQLG
         zMTpKEk0T7VYxxstPepD5a5NIMCYhrfITh4bd6dKCGQzVUf0K0TmPSctrkHl4VnL6k
         VN4JZDzcasauQ==
Date:   Wed, 6 Apr 2022 13:59:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Message-ID: <20220406185931.GA165754@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405235315.GA101393@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 05, 2022 at 06:53:17PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 24, 2022 at 05:52:19PM +0000, Mark Brown wrote:
> > On Wed, Mar 23, 2022 at 11:47:08PM -0700, KernelCI bot wrote:
> > 
> > The KernelCI bisection bot has identified commit 5949965ec9340cfc0e
> > ("x86/PCI: Preserve host bridge windows completely covered by E820")
> > as causing a boot regression in next on asus-C523NA-A20057-coral (a
> > Chromebook AIUI).  Unfortunately there's no useful output when starting
> > the kernel.  I've left the full report below including links to the web
> > dashboard.
> > 
> > The last successful boot in -next had this log:
> > 
> >    https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
> > 
> > I'd also note that the machine hp-x360-12b-n4000-octopus appears to have
> > started failing at the same time with similar symptoms, failing log:
> > 
> >    https://storage.kernelci.org/next/master/next-20220324/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-n4000-octopus.html
> 
> Is there any way to get the contents of:
> 
>   /sys/firmware/acpi/tables/DSDT
>   /sys/firmware/acpi/tables/SSDT*
> 
> from these Chromebooks?

Is there hope for this, or should I look for another way to get this
information?

Thanks,
  Bjorn
