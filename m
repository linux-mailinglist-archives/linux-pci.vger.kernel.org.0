Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A537476D7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGDQhT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjGDQhS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 12:37:18 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283A6CF;
        Tue,  4 Jul 2023 09:37:18 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b7ef3e74edso29177865ad.0;
        Tue, 04 Jul 2023 09:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488637; x=1691080637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq9caxBhUaIDTOUts0hMPoGeTAHn1nr/fwkbfDRFOV4=;
        b=DRODGkvGkssu8sbpH5JfFdL0Dwx1OfH+U7SSFY6gIJ0v6LTLqeNqjhBf8nmyPy4gG2
         oiNgpFAtVRu9NdjJ8AXflAkzXUDRBtm1DwKH6+dv1MqxwskzxumNO5juQO8oDWlkMBY8
         oMbR6wrLHLaBYM3LSFbtupluYCA8UKra9TkS14fNUvBVnA50/sSvLxoG+0JRkMGxohtC
         4XFthla/1NcoJIUkd+Nh6VfWNefjn3uzOfEVCLURL1eFBJPdi9+Ej0TIRoo94qo1q9N5
         YY+bjRQ9RjJcevtmfry7JvF1lFpLiu1nEkmZpTbFpZgJt7x1T83M/CiMTZTyCmMzQs3j
         A+Ww==
X-Gm-Message-State: ABy/qLZkIhcqZa19ZXVgKzV3v167qMEV//dp+1Hr1qss+3U2TLyIUTvb
        irGKM6CN31PVMcqsDLArFdE=
X-Google-Smtp-Source: APBJJlFLrXdz6T8wRfchr9R6PTEOz95tWasBcijz9afT2zIq9026AzCHmKf2iLbvuD5b+Zi1eMkf+g==
X-Received: by 2002:a17:902:8682:b0:1b8:95fc:d12 with SMTP id g2-20020a170902868200b001b895fc0d12mr4921692plo.54.1688488637557;
        Tue, 04 Jul 2023 09:37:17 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001b8918da8d1sm4605652plj.80.2023.07.04.09.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:37:15 -0700 (PDT)
Date:   Wed, 5 Jul 2023 01:37:13 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, dlemoal@kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI
 address
Message-ID: <20230704163713.GB435329@rocinante>
References: <20230703085845.2052008-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703085845.2052008-1-rick.wertenbroek@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> A 32-bit mask was used on the 64-bit PCI address used for mapping MSIs.
> This would result in the upper 32 bits being unintentionally zeroed and
> MSIs getting mapped to incorrect PCI addresses if the address had any
> of the upper bits set.
> 
> Replace 32-bit mask by appropriate 64-bit mask.

Applied to controller/rockchip, thank you!

[1/1] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address
      https://git.kernel.org/pci/pci/c/251c859f4b6f

	Krzysztof
