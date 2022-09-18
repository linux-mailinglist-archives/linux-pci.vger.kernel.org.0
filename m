Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04E25BC0BB
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 01:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIRX6r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Sep 2022 19:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIRX6r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Sep 2022 19:58:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D50013F46;
        Sun, 18 Sep 2022 16:58:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so4557780pjo.2;
        Sun, 18 Sep 2022 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nx+a1DvWCBo5ERwaVpW/CuMoX39dd2IN65mPeOU18nk=;
        b=Htjm9zpZ8qet43rd+8hciEkngTT3Mf9gh89SN468HcXRk3ucOGAT1qqtAaMZEhnQ+5
         HKO+dyYDDMbhTRmR9hOlUZiBKcCB5G0vFFFNhO2usZIIwCq/GpbIZ1mREUUbG/kdm4XB
         UxUE5tOK0KIq7xMEdNi6auBBrWyHMhS4LBqq3mCSeeqyLbVhnpEd0YQo4v6MFY894bHM
         VWFH8AE2DMrvKVROiH7xLpQBS9euYX87lvN5EMyugwHztkvEzA/j9PahLolBMAjWypAu
         NI6xV55ezEdKYSo+kMyCRrRs3o7PeEUCSt4OF7VYnS4cLQbwWcHem9cjtg2IwW4K9/NS
         O5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nx+a1DvWCBo5ERwaVpW/CuMoX39dd2IN65mPeOU18nk=;
        b=WD5P5wmLbWIAwF/ob8uD7y3pEJIMLmA5+34GUqMtxpaYjAI/dZej1070Mg5ms4R97W
         HWwVZ9WqsSfEx8vSK+w0ijMntKg0KmUQV63QCdw1WmVUp1DagEvChOznN4USrG4S5Qqt
         7qKUG4zHBdrhLrO/wE3jjBYSn+WpH6/L3+6LQ0PtOn6IkVbHJR7Qtaqm3w3uXj6YOI+6
         2/lu0HGp9Uh0iO/TstpsIRVsgAKwE1r8bb2akrMQ3LUrfWQCrhLi9eY9j18A+nu1d2uk
         kxWTs00jsV5b9CQ1A6dyYisxx+yqZK62jg9+iP/g0oT0w7nvilBAa3VNRJtWYM3rKbLi
         ABoQ==
X-Gm-Message-State: ACrzQf1A52j9P2uISoFkEm9JeQ3XH+e2I5H7FHaGdNz6ZAuMTp+BVGP/
        thWdEcK3dZgSlePQrbNFXBM=
X-Google-Smtp-Source: AMsMyM5JrmjGJS75CgJbj2qzE8nX2qZTU6YGWXhtv3RzUnrmmUM4+ok+8STh+zELYZx4q+Rhpj5X6Q==
X-Received: by 2002:a17:90b:1e0d:b0:202:91ec:e167 with SMTP id pg13-20020a17090b1e0d00b0020291ece167mr16593865pjb.174.1663545525697;
        Sun, 18 Sep 2022 16:58:45 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id 75-20020a62164e000000b005499599ed30sm8113030pfw.10.2022.09.18.16.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 16:58:45 -0700 (PDT)
Date:   Mon, 19 Sep 2022 07:58:38 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
Message-ID: <Yyewrm+/viScefKC@sol>
References: <20220906214114.vj3v32dzwxz6uqik@pali>
 <YxfBKkqce/IQQLk9@google.com>
 <20220906220901.p2c44we7i4c35uvx@pali>
 <YxfMkzW+5W3Hm1dU@google.com>
 <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
 <CAMRc=MdrX5Pz1d-SM2PPikEYw0zJBe6GCdr4pEfgBLMi1J9PAQ@mail.gmail.com>
 <YyKMsyI961Mo1EQE@sol>
 <CACRpkdYB6dZf4TBhfXB2Z5E2PJ46ctAM_QKLiW-fykbCopcVGQ@mail.gmail.com>
 <YyLwsOBXv9jRw/+n@sol>
 <CAMRc=MeF2uNmx_-mZikg=3nMV4aHK+bCUBEcLGEgJ6JY4jZ_Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeF2uNmx_-mZikg=3nMV4aHK+bCUBEcLGEgJ6JY4jZ_Sg@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 16, 2022 at 09:22:59AM +0200, Bartosz Golaszewski wrote:
> On Thu, Sep 15, 2022 at 11:30 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > Enums work for me - especially if the goal is to differentiate
> > logical from physical - there should be a distinct enum for each.
> >
> 
> We won't even have to change the function signatures if we go with
> enums - they already take an int and I'm in general against putting
> enum types into function signatures in C as they give you a false
> sense of a strong type.
> 

IMO it is far easier to remember that C doesn't range check enums than it
is to remember what specific values are appropriate for a function
accepting an enum as int.  A specified type is a strong hint, and unlike
documentation is one that an IDE can parse and provide valid options for.

Passing enums as int is the norm in the kernel, so fair enough to keep
it that way, but that does contribute to the confusion that we are trying
to address here.

Cheers,
Kent.

