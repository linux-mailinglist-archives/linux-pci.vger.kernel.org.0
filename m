Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B216D3D24
	for <lists+linux-pci@lfdr.de>; Mon,  3 Apr 2023 08:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjDCGLd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 02:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDCGLb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 02:11:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED37359C8;
        Sun,  2 Apr 2023 23:11:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so112711827edd.5;
        Sun, 02 Apr 2023 23:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680502288;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+PPixoHRDJ+Gnyytgct7eIf2W8PC3hRBuJOLjuDKdhY=;
        b=iUB0JuzYzSTrZD/+G5G3iSZ+1srHcDapp+2yS8gUivSygEUOGHpj4cZmiOWxHvgQTy
         iE+RPPaYIQ5Qi0ZZmd24zNSLYCD3sJsMCKGGJGByokv6zZ2zCyyW5xNTZ5zOplMQGJ0R
         vgUFHkowl5yEBomYvwjill8yyhPtqe0AKiXgA57CND9aKt2qCFWEI7/f/0+r0pMXCYEM
         nhsA71AVUwIGCI1HggH0vhhR099IYLKEehb+2/sLHOUErs2O5i5gF49rZge+iRglsVoC
         t06dNmIb1MPArzL9pQYEGx9DCS+7iALBmKTPCavs4MrxLEwDUHFXfT6L8yLSh6o6H+DO
         sTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680502288;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PPixoHRDJ+Gnyytgct7eIf2W8PC3hRBuJOLjuDKdhY=;
        b=bBCb7xF1KpOYjlso8EBMVI40mQOgN1sNqymNF+o/pTd9p6b/uUIFrI5lQzy4W2IXjf
         kGY7JfqPHufysnCt0ldWYP55h4zZh51S/5AAeiMoy6jw942y7LgA9a+y1dvwqg3wenE0
         L2xO6Od6kfwrNrKfAPWGjhuIqX7qZiDADRtctneTxlWEZbP7cnmTPzeMHRPFL7jXo7UE
         lk3gw8g9U+2kMZMkj4jogI0KCF75XGVZ8yVDbxA0dzsCAnW4St55XayFEcbHSkpXLStR
         nPyCEsJ5HzT/nX4e8eCLqKlAvm//mnOCtMGfgQYZzPhc14IiJuGnHrFBxs3dglewWPJp
         2/tw==
X-Gm-Message-State: AAQBX9djJ70UKfSnTojEGZIcVK6rK0gv0DNLx9IT1/zJqB4bNSwakcQN
        k7IbhpNK76Va45v4CJAmRCs=
X-Google-Smtp-Source: AKy350bBekRezxNQa7MFP8TwmpOwouUosfhIi/lGMrCD5/RMtWc0098xCYnOuGzvNELlfMlv0AK2gA==
X-Received: by 2002:a17:906:eca1:b0:920:254c:1e2d with SMTP id qh1-20020a170906eca100b00920254c1e2dmr36630296ejb.39.1680502288354;
        Sun, 02 Apr 2023 23:11:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090676cf00b00947c0cecceasm3471757ejn.206.2023.04.02.23.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 23:11:28 -0700 (PDT)
Date:   Mon, 3 Apr 2023 09:09:01 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, ye.xingchen@zte.com.cn, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] PCI: mt7621: Use dev_err_probe()
Message-ID: <4cfaa4eb-24ff-4129-b549-bd5a66352e9b@kili.mountain>
References: <202303231145121987818@zte.com.cn>
 <22081108-565d-4608-97f7-6e40ca3df2b6@kili.mountain>
 <CAMhs-H9m=ZGREMo_upE3M48sQb-WpU3j2_b2xLyO2mDkezxC9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMhs-H9m=ZGREMo_upE3M48sQb-WpU3j2_b2xLyO2mDkezxC9g@mail.gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 03, 2023 at 07:05:56AM +0200, Sergio Paracuellos wrote:
> On Mon, Apr 3, 2023 at 6:41 AM Dan Carpenter <error27@gmail.com> wrote:
> >
> > Hi,
> >
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/ye-xingchen-zte-com-cn/PCI-mt7621-Use-dev_err_probe/20230323-114623
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> > patch link:    https://lore.kernel.org/r/202303231145121987818%40zte.com.cn
> 
> So, I already replied to this proposed patch clearly saying that this
> makes the rest of the code unreachable, so it is a clear NAK.
> Why is this applied to the intel-lab-lkp tree? Just to be able to test
> the changes?
> 

These emails are automatically generated by kbuild-bot.  I don't know
how kbuild-bot internals work.  I just review some of the Smatch related
warnings and hit forward or ignore them.

Normally, I don't look at the context outside of the email but to be
honest, I was curious enough about this one that I looked it up on the
list.  I knew it was NAKed but I set the email anyway hoping that maybe
people would see the extra Smatch warning and be encouraged to run
Smatch on their code in the future to avoid potential embarrassment.

regards,
dan carpenter


