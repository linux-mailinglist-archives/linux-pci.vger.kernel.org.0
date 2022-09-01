Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106BB5A9D45
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 18:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiIAQlx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 12:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiIAQlv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 12:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF30274DC5
        for <linux-pci@vger.kernel.org>; Thu,  1 Sep 2022 09:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C3D161FBB
        for <linux-pci@vger.kernel.org>; Thu,  1 Sep 2022 16:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599A6C433C1;
        Thu,  1 Sep 2022 16:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662050508;
        bh=063h7EZSG2QQdaSqJ02sajP6jL6+DO50/yOrCllwwKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L21DS4aADXTFi3JF9DpHPyPtl2k+TZVyDf1QouWeNgAc3A8ZXANVn6xmTUKFUOaFi
         zY9/c9+ruxMf3JjlCU+xnasARn1kuqq810aOkmanXepEEGfQ65AKo+fqffVNNxDzOx
         NxYp4QXcIakWhiEQN2FBXWAOXzQAgMxX/FKi4p3I=
Date:   Thu, 1 Sep 2022 18:41:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     Dongdong Liu <liudongdong3@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] changes to driver_override parsing broke DPDK script
Message-ID: <YxDgyY4wtGDy1Koy@kroah.com>
References: <20220809192102.GA1331186@bhelgaas>
 <af880c1a-cedd-181f-9b4d-2f1766312fc0@linaro.org>
 <YvNMFR1dgtShQJju@kroah.com>
 <YvNqnSGDKm0LyJwH@kroah.com>
 <872d304a-3aa0-53a4-c26a-3cb30594274d@huawei.com>
 <f8825129-1566-df86-ade3-8d2885ce90b3@huawei.com>
 <YvXpQrQ5DToXWVWm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvXpQrQ5DToXWVWm@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 12, 2022 at 07:46:42AM +0200, Greg KH wrote:
> On Fri, Aug 12, 2022 at 10:54:38AM +0800, lihuisong (C) wrote:
> > 
> > 在 2022/8/12 9:48, Dongdong Liu 写道:
> > > cc Huisong who found the issue.
> > > 
> > > On 2022/8/10 16:21, Greg KH wrote:
> > > > On Wed, Aug 10, 2022 at 08:11:33AM +0200, Greg KH wrote:
> > > > > On Wed, Aug 10, 2022 at 08:54:36AM +0300, Krzysztof Kozlowski wrote:
> > > > > > On 09/08/2022 22:21, Bjorn Helgaas wrote:
> > > > > > > [+cc regressions list]
> > > > > > > 
> > > > > > > 23d99baf9d72 appeared in v5.19-rc1.
> > > > > > > 
> > > > > > > On Tue, Aug 09, 2022 at 11:29:43AM -0700, Stephen Hemminger wrote:
> > > > > > > > This commit broke the driver override script in DPDK.
> > > > > > > > This is an API/ABI breakage, please revert or fix the commit.
> > > > > > > > 
> > > > > > > > Report of problem:
> > > > > > > > http://mails.dpdk.org/archives/dev/2022-August/247794.html
> > > > > > 
> > > > > > Thanks for the report. I'll take a look.
> > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > commit 23d99baf9d729ca30b2fb6798a7b403a37bfb800
> > > > > > > > Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > > > > Date:   Tue Apr 19 13:34:28 2022 +0200
> > > > > > > > 
> > > > > > > >     PCI: Use driver_set_override() instead of open-coding
> > > > > > > > 
> > > > > > > >     Use a helper to set driver_override to the
> > > > > > > > reduce amount of duplicated
> > > > > > > >     code.  Make the driver_override field const
> > > > > > > > char, because it is not
> > > > > > > >     modified by the core and it matches other subsystems.
> > > > > > > > 
> > > > > > > >     Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > > >     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > > > > >     Signed-off-by: Krzysztof Kozlowski
> > > > > > > > <krzysztof.kozlowski@linaro.org>
> > > > > > > >     Link: https://lore.kernel.org/r/20220419113435.246203-6-krzysztof.kozlowski@linaro.org
> > > > > > > >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > > 
> > > > > > > > 
> > > > > > > > The script is sending single nul character to remove override
> > > > > > > > and that no longer works.
> > > > > > 
> > > > > > The sysfs API clearly states:
> > > > > > "and
> > > > > >  may be cleared with an empty string (echo > driver_override)."
> > > > > > Documentation/ABI/testing/sysfs-bus-pci
> > > > > > 
> > > > > > Sending other data and expecting the same result is not conforming to
> > > > > > API. Therefore we have usual example of some undocumented
> > > > > > behavior which
> > > > > > user-space started relying on and instead using API, user-space expect
> > > > > > that undocumented behavior to be back.
> > > > > > 
> > > > > > Yay! I wonder what is the point to even describe the ABI if user-space
> > > > > > can simply ignore it?
> > > > > 
> > > > > One can argue that a string of just '\0' is an "empty string" and we
> > > > > should be able to properly handle this in the kernel.  Heck,
> > > > > "\0\0\0\0\0\0" is also an "empty string", right?
> > > > > 
> > > > > I don't have an issue with fixing the kernel up here, it should be able
> > > > > to handle this.
> > > > 
> > > > Stephen, does the patch below fix this for you?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > > -----------------
> > > > 
> > > > diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> > > > index 15a75afe6b84..676b6275d5b5 100644
> > > > --- a/drivers/base/driver.c
> > > > +++ b/drivers/base/driver.c
> > > > @@ -63,6 +63,12 @@ int driver_set_override(struct device *dev, const
> > > > char **override,
> > > >      if (len >= (PAGE_SIZE - 1))
> > > >          return -EINVAL;
> > > > 
> > > > +    /*
> > > > +     * Compute the real length of the string in case userspace
> > > > sends us a
> > > > +     * bunch of \0 characters like python likes to do.
> > > > +     */
> > > > +    len = strlen(s);
> > > > +
> > > >      if (!len) {
> > > >          /* Empty string passed - clear override */
> > > >          device_lock(dev);
> > > > .
> > > > 
> > > This patch looks good,  @huisong, please help to test the patch.
> > > 
> > > Thanks,
> > > Dongdong
> > > .
> > Tested-by: Huisong Li <lihuisong@huawei.com>
> 
> Wonderful, thanks!  I'll queue this up to send to Linus after -rc1 is
> out.

Sorry for the delay, now sent to lkml:
	https://lore.kernel.org/r/20220901163734.3583106-1-gregkh@linuxfoundation.org
