Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074C658E90C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiHJIuS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 04:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiHJIuP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 04:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA813F0B
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 01:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CDFF60FA4
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 08:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EFCC433D6;
        Wed, 10 Aug 2022 08:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660121411;
        bh=ap+hpUr2Kf2miYTkYGgjpmcTT7rWQANkjKa3FY8YMcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zQIBofpETTExNY4SKRGkV1ULfy0bADSKTO4y7SUEBnsb8pnwdau5cEUkrCl4mpVkg
         fJJ93Lk2rHo8PQA+YlAYq+NXHqIjEZqNiIwz6eATF4O8lUpfbTZVEzZSJrm4dITxoY
         K/tSFhxVzORQU63ACh/wfbJ2MF3exBoToGOFRiLo=
Date:   Wed, 10 Aug 2022 08:11:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [REGRESSION] changes to driver_override parsing broke DPDK script
Message-ID: <YvNMFR1dgtShQJju@kroah.com>
References: <20220809192102.GA1331186@bhelgaas>
 <af880c1a-cedd-181f-9b4d-2f1766312fc0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af880c1a-cedd-181f-9b4d-2f1766312fc0@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 10, 2022 at 08:54:36AM +0300, Krzysztof Kozlowski wrote:
> On 09/08/2022 22:21, Bjorn Helgaas wrote:
> > [+cc regressions list]
> > 
> > 23d99baf9d72 appeared in v5.19-rc1.
> > 
> > On Tue, Aug 09, 2022 at 11:29:43AM -0700, Stephen Hemminger wrote:
> >> This commit broke the driver override script in DPDK.
> >> This is an API/ABI breakage, please revert or fix the commit.
> >>
> >> Report of problem:
> >> http://mails.dpdk.org/archives/dev/2022-August/247794.html
> 
> Thanks for the report. I'll take a look.
> 
> >>
> >>
> >> commit 23d99baf9d729ca30b2fb6798a7b403a37bfb800
> >> Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Date:   Tue Apr 19 13:34:28 2022 +0200
> >>
> >>     PCI: Use driver_set_override() instead of open-coding
> >>     
> >>     Use a helper to set driver_override to the reduce amount of duplicated
> >>     code.  Make the driver_override field const char, because it is not
> >>     modified by the core and it matches other subsystems.
> >>     
> >>     Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >>     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >>     Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>     Link: https://lore.kernel.org/r/20220419113435.246203-6-krzysztof.kozlowski@linaro.org
> >>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>
> >>
> >> The script is sending single nul character to remove override
> >> and that no longer works.
> 
> The sysfs API clearly states:
> "and
>  may be cleared with an empty string (echo > driver_override)."
> Documentation/ABI/testing/sysfs-bus-pci
> 
> Sending other data and expecting the same result is not conforming to
> API. Therefore we have usual example of some undocumented behavior which
> user-space started relying on and instead using API, user-space expect
> that undocumented behavior to be back.
> 
> Yay! I wonder what is the point to even describe the ABI if user-space
> can simply ignore it?

One can argue that a string of just '\0' is an "empty string" and we
should be able to properly handle this in the kernel.  Heck,
"\0\0\0\0\0\0" is also an "empty string", right?

I don't have an issue with fixing the kernel up here, it should be able
to handle this.

thanks,

greg k-h
