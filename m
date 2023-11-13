Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFB57E99D5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 11:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjKMKJU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 05:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMKJT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 05:09:19 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83544D58;
        Mon, 13 Nov 2023 02:09:16 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1cc4f777ab9so30121685ad.0;
        Mon, 13 Nov 2023 02:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699870156; x=1700474956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtssXOhT1IjkLH8DCwvrp9grDBN4NL0H2Di/o5vivrg=;
        b=vYcRJIGHtzTkFTefeHZj8r/upczaPY1uihgKANeALrGf6E7w+fg5YhQefD2ZdV1oNc
         raP58vv94jgjWIi+RRMsGStVJH32HPrNbvHOkJwOpzwVpruJuf/mw7OWEJelEkc8DBsF
         YXl2g6ctRkyNyQRiAsELnCR1EuCz/zAjWtMD5TaS66ut5GQ+2t5AU0pv3wlZm/Gn6stX
         yeYUAZvQepe8zx+hML19nDROjVi1lVGrL8nZoIplnv5LrorXDBNHv4vUStkrqEBQ44xP
         Cljf7bDeppjszMnUT9PDG2LoNGMO6Fc9YFC6V1rIoNjuCHnhgLkIHqtZZNj2V1mYBBP/
         X9Ig==
X-Gm-Message-State: AOJu0Yz9om5Wt6T9fijlBXDU7cukUvtuu4hI36bbXylBDGG9MzNBoubV
        HTpAMgzRa/v1aC/bCvTA/a4=
X-Google-Smtp-Source: AGHT+IGj6vUeUwfKU7nKXujpx369C8OQBBOgD1h6Il4RG1NldEGkeXRi0upURBkbSxn6ENkTD/+7LA==
X-Received: by 2002:a17:902:e552:b0:1ca:a290:4c0c with SMTP id n18-20020a170902e55200b001caa2904c0cmr5440330plf.16.1699870155884;
        Mon, 13 Nov 2023 02:09:15 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902d4c600b001cc56354cc8sm3741846plg.62.2023.11.13.02.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:09:15 -0800 (PST)
Date:   Mon, 13 Nov 2023 19:09:14 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mani@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        roy.zang@nxp.com, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: dwc: Improve code readability
Message-ID: <20231113100914.GB1583963@rocinante>
References: <20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro!

> This patch series is based on the latest pci.git / next branch.
[...]

Thank you for following up to tidy things up!  Much appreciated.

Now, while you are looking at things, can you also take care about the following:

  drivers/pci/controller/dwc/pcie-rcar-gen4.c:439:15: warning: cast to smaller integer type 'enum dw_pcie_device_mode' from 'const void *' [-Wvoid-pointer-to-enum-cast]

This requires adding structs for each data member of the of_device_id type.

Some examples from other drivers:

  - https://elixir.bootlin.com/linux/v6.6.1/source/drivers/pci/controller/dwc/pcie-tegra194.c#L2440
  - https://elixir.bootlin.com/linux/v6.6.1/source/drivers/pci/controller/dwc/pci-keystone.c#L1074

Thank you! :)

	Krzysztof
