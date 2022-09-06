Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762B25AF80B
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 00:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiIFWl2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 18:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIFWl2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 18:41:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C3792F6;
        Tue,  6 Sep 2022 15:41:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z9-20020a17090a468900b001ffff693b27so11504666pjf.2;
        Tue, 06 Sep 2022 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=7NpfrCk+6A3z0LsR2jUu08sOxiRJrMwnOcQCIaNlAQE=;
        b=fnZfa2SY63h0To/ZunyJoMLSLzjEHx8OFYvv/mdfiWDX1CkKIxHgVViAFQfzkqMAV9
         lLRW+Fo7zuecm+NsXbCE0/nnjPh7t4U183741qgpCAr84bWLsNln5w8UoNKfWSETFJ4S
         fPWwnPK6LNJGug7UqJotGixvVrS4N8U6B3R0i1y64jLuO1mMUmdSt5FL9cHfyTlIeNDb
         vPM3i5kDgjE4ZDZd87JANfVa8mqWu/umTmzGwJctpD3CgV12LaEy00V5/rTtG/LjDA3X
         3ZzgmubtffFxtC7sTLbAO82ZkYErMmBwd0g5NBk5dy8NtZW0qtkk2mfRJ4bgax0T0+GS
         upSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7NpfrCk+6A3z0LsR2jUu08sOxiRJrMwnOcQCIaNlAQE=;
        b=GHm82gu0+EhVOkyqz0j1CK3D7+z4SUIEq9oH9SZDtSYDx9IJIPQmT6GpUl7JSCR27D
         Tpyn1pccZPuDhF+hWaNP0l+ajyq92P06AQ3nfiroHWz2hn0UsDohWdS6ggyMJQrEXDcf
         1pxNjdwolY0F7bSST03YCx19jxUjwF1iPz5BFvk0fMl6T8kaMeH3caJ0+ciT3HjZy8sD
         +zQ04F5Mh/eq6ppGb+BdDCEdUqZmubWiLRfCMnq0NrbXAmaEx6QDzfxOAB61crgrjS5N
         wlXUx5U0dqAyR1N4fIBqDx4nybaEIWL3isI/p98oMCGBPhutLNqgabTOZJ1EBcqsSZYH
         qbng==
X-Gm-Message-State: ACgBeo0+Y0lAffh0ywjXiNvQv53Gi2OBoer8D2jRAsfblJmj+3BKgdQz
        U2C/TxKJboMZaT6wHjbLAo4=
X-Google-Smtp-Source: AA6agR7a3kLQBMn0Ka4nspJdGDzNm+jwOaTDY1aD+Liwcp05OMgI6xyBv+MKXF+LwG5VWq27jisE6w==
X-Received: by 2002:a17:902:f686:b0:175:44a:c707 with SMTP id l6-20020a170902f68600b00175044ac707mr732672plg.62.1662504086502;
        Tue, 06 Sep 2022 15:41:26 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id r12-20020aa7988c000000b0053612ec8859sm10689315pfl.209.2022.09.06.15.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 15:41:26 -0700 (PDT)
Date:   Tue, 6 Sep 2022 15:41:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
Message-ID: <YxfMkzW+5W3Hm1dU@google.com>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
 <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com>
 <20220906214114.vj3v32dzwxz6uqik@pali>
 <YxfBKkqce/IQQLk9@google.com>
 <20220906220901.p2c44we7i4c35uvx@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906220901.p2c44we7i4c35uvx@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 07, 2022 at 12:09:01AM +0200, Pali Rohár wrote:
> On Tuesday 06 September 2022 14:52:42 Dmitry Torokhov wrote:
> > On Tue, Sep 06, 2022 at 11:41:14PM +0200, Pali Rohár wrote:
> > > On Tuesday 06 September 2022 14:26:32 Dmitry Torokhov wrote:

> > > would not be such easy as during startup we need to reset endpoint card.
> > > Normally just putting it from reset, but if card was not reset state
> > > prior probing driver then it is needed to first put it into reset...
> > > 
> > > I would fix it this issue after your patch is merged to prevent any
> > > other merge conflicts.
> > > 
> > > How to tell devm_fwnode_gpiod_get() function that caller is not
> > > interested in changing signal line? Just by changing GPIOD_OUT_HIGH to 0?
> > 
> > I think there are 2 options:
> > 
> > 1. Start with GPIOD_OUT_LOW (i.e. reset is explicitly deasserted), and
> > then in powerup/powerdown you do explicit on/off transitions with proper
> > timings.
> 
> PERST# is active-low. So deasserting means to put it into high state.
> But device tree can specify if line is active-high as on some board
> designs is GPIO output connected to inverter (or to level shifter with
> additional logic of signal inversion). So what [GPIOD_]OUT_LOW means in
> this context? Just it is needed that from driver point of view always
> value 1 means reset active and 0 means reset inactive, independently of
> double (triple?) inversions.

Think of GPIOD_OUT_LOW and GPIOD_OUT_HIGH as logical off and on, or
logical deactivate/activate. Gpiolib will take into account declared
polarity of the line when it drives the output, so for lines marked as
GPIO_ACTIVE_HIGH GPIO_OUT_HIGH will result in line driven HIGH, whereas
for lines marked as GPIO_ACTIVE_LOW GPIO_OUT_HIGH will result in the
line being driven LOW.

Linus, do you think we should introduce GPIOD_OUT_INACTIVE /
GPIOD_OUT_ACTIVE or GPIOD_OUT_DEASSERTED / GPIOD_OUT_ASSERTED and
deprecate existing GPIOD_OUT_LOW and GPIO_OUT_HIGH?

Thanks.

-- 
Dmitry
