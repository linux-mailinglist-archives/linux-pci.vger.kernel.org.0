Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12858E90D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 10:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiHJIuZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiHJIuY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 04:50:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667B0FD17
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 01:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8C8DB81B3A
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 08:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A221DC433B5;
        Wed, 10 Aug 2022 08:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660121420;
        bh=apg3OEJoYJrBH0EU36EwV5KUXtmT9zQg9lbHi1C/AIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x7qurrStAn97EAjHJ8iDG8RnHtIdeAAPTkv0F69A3h5KWR3d/wB3ilwXKm9LzLIxK
         544u+I+FjouJZdBs5gJhMwd29p4XFWRE7huaOV7F4uhgfnwStJGjZ/lgjckPahAy6A
         TdjDnh0SOOBuME/MXlm/8mlTEVZvMVkAl1eMKCXg=
Date:   Wed, 10 Aug 2022 10:21:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] changes to driver_override parsing broke DPDK script
Message-ID: <YvNqnSGDKm0LyJwH@kroah.com>
References: <20220809192102.GA1331186@bhelgaas>
 <af880c1a-cedd-181f-9b4d-2f1766312fc0@linaro.org>
 <YvNMFR1dgtShQJju@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvNMFR1dgtShQJju@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 10, 2022 at 08:11:33AM +0200, Greg KH wrote:
> On Wed, Aug 10, 2022 at 08:54:36AM +0300, Krzysztof Kozlowski wrote:
> > On 09/08/2022 22:21, Bjorn Helgaas wrote:
> > > [+cc regressions list]
> > > 
> > > 23d99baf9d72 appeared in v5.19-rc1.
> > > 
> > > On Tue, Aug 09, 2022 at 11:29:43AM -0700, Stephen Hemminger wrote:
> > >> This commit broke the driver override script in DPDK.
> > >> This is an API/ABI breakage, please revert or fix the commit.
> > >>
> > >> Report of problem:
> > >> http://mails.dpdk.org/archives/dev/2022-August/247794.html
> > 
> > Thanks for the report. I'll take a look.
> > 
> > >>
> > >>
> > >> commit 23d99baf9d729ca30b2fb6798a7b403a37bfb800
> > >> Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >> Date:   Tue Apr 19 13:34:28 2022 +0200
> > >>
> > >>     PCI: Use driver_set_override() instead of open-coding
> > >>     
> > >>     Use a helper to set driver_override to the reduce amount of duplicated
> > >>     code.  Make the driver_override field const char, because it is not
> > >>     modified by the core and it matches other subsystems.
> > >>     
> > >>     Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >>     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > >>     Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >>     Link: https://lore.kernel.org/r/20220419113435.246203-6-krzysztof.kozlowski@linaro.org
> > >>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >>
> > >>
> > >> The script is sending single nul character to remove override
> > >> and that no longer works.
> > 
> > The sysfs API clearly states:
> > "and
> >  may be cleared with an empty string (echo > driver_override)."
> > Documentation/ABI/testing/sysfs-bus-pci
> > 
> > Sending other data and expecting the same result is not conforming to
> > API. Therefore we have usual example of some undocumented behavior which
> > user-space started relying on and instead using API, user-space expect
> > that undocumented behavior to be back.
> > 
> > Yay! I wonder what is the point to even describe the ABI if user-space
> > can simply ignore it?
> 
> One can argue that a string of just '\0' is an "empty string" and we
> should be able to properly handle this in the kernel.  Heck,
> "\0\0\0\0\0\0" is also an "empty string", right?
> 
> I don't have an issue with fixing the kernel up here, it should be able
> to handle this.

Stephen, does the patch below fix this for you?

thanks,

greg k-h

-----------------

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 15a75afe6b84..676b6275d5b5 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -63,6 +63,12 @@ int driver_set_override(struct device *dev, const char **override,
 	if (len >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
+	/*
+	 * Compute the real length of the string in case userspace sends us a
+	 * bunch of \0 characters like python likes to do.
+	 */
+	len = strlen(s);
+
 	if (!len) {
 		/* Empty string passed - clear override */
 		device_lock(dev);
