Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9986D5AF714
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 23:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIFVkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 17:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIFVkU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 17:40:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C85127B2C;
        Tue,  6 Sep 2022 14:40:19 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so11794471pgb.4;
        Tue, 06 Sep 2022 14:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=KRNnNW5gop8MgB96pBKivy08fdE2kbwt/8Fs47522vs=;
        b=hTESb0DrBoIe3vVqHk+Qi+WRzS9jGZRFdl1dVXMEI8ergblTBCFY9Gx9Ccj5YgRhh/
         +RpF/2QnwVaoTJDsO4ch7k0epWUEwNcgP17FSbncVCMHkpw7mOFtJygJkGmQMYfyPNDf
         MknLLZi+ut2xe0wjgxO9lOgw6KHChgUXPGn2OzBr7IWa7bkwXP9gYrs9eVZI1KJEODeT
         JoYAjgKNxOIHhnN1kJ4FXHKtr6HG6oOi65Un4tYBDwZ6zMNWE9d3sQykpNttuqoGDe8e
         IEQLs2qhY66WkQEJU1X6IfI8Bm5V0kMpxt0C37bkSiAl/ZwWQ9hlUsyYebTtgKgCWR1G
         q5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KRNnNW5gop8MgB96pBKivy08fdE2kbwt/8Fs47522vs=;
        b=OiRKH6xXE9nV05JyY7Moo/KRom6dAz1+jIfCn5zZjZMIvGCldvmoKPpVecJxHyPq1Q
         YJeMmjC1Qv3ALDx7LcqBaNFoiWwAkTrGZSDIrHVSvHzfB2aiYlheld/aGqNhA3ClNLbS
         /FnA67KT3XEo5EiHKfFOA9OaO820wXz/rkUePasjwvI5/iMoSdWY6juK8TRXn8LrIq/L
         Ha2et7hZRqVmteStsEU07T9ndyKqqoLd2aCFDRinyMM93xbzOPmgtPEtydS+V6DgzZhv
         2kQMDtdldJn6LGKgtLsVr+tlUjp66wIyjLfoa+4tnS2TM38rUYfSpF3pQKKgmKVf6yil
         Y9/g==
X-Gm-Message-State: ACgBeo19iuXgAJXMqY+OpkzHv8MyNIEpnCvXJrqcu3cKAFQ8n/2RzmFG
        v8E+v+SnM8qXQVFQnSf/YaM=
X-Google-Smtp-Source: AA6agR6HctpHojcywer9BiWD/Q7J0VF5O8UBtoJMVR4KzCb5EF934R3kjDC+D/uCU4H46Hy8I8Anww==
X-Received: by 2002:a63:d607:0:b0:427:bc0c:55c8 with SMTP id q7-20020a63d607000000b00427bc0c55c8mr578538pgg.402.1662500418958;
        Tue, 06 Sep 2022 14:40:18 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id k88-20020a17090a14e100b00200a5e50094sm1848653pja.48.2022.09.06.14.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:40:18 -0700 (PDT)
Date:   Tue, 6 Sep 2022 14:40:15 -0700
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
Message-ID: <Yxe+P27mwZQMZK+5@google.com>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
 <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yxe7CJnIT5AiUilL@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 02:26:32PM -0700, Dmitry Torokhov wrote:
> Hi Pali,
> 
> On Tue, Sep 06, 2022 at 11:16:28PM +0200, Pali Rohár wrote:
> > Hello!
> > 
> > On Tuesday 06 September 2022 13:43:01 Dmitry Torokhov wrote:
> > > This patch switches the driver away from legacy gpio/of_gpio API to
> > > gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> > > make private to gpiolib.
> > 
> > There are many pending pci-mvebu.c patches waiting for review and merge,
> > so I would suggest to wait until all other mvebu patches are processed
> > and then process this one... longer waiting period :-(
> 
> OK, it is not super urgent. OTOH it is a very simple patch :)

By the way, do the pending patches address soft-leaking of reset GPIO
when the driver fails to acquire clock for a port (I called it
soft-leaking since devm will free it on unbind)?

Thanks.

-- 
Dmitry
