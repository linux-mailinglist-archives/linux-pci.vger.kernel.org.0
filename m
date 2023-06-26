Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682F873E3CF
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 17:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjFZPqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjFZPp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 11:45:58 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9917B10E9;
        Mon, 26 Jun 2023 08:45:40 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-66869feb7d1so1727968b3a.3;
        Mon, 26 Jun 2023 08:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687794340; x=1690386340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqM0x+lEbNwzWnLB8cFDRDG++2DUMupMoDamNLkl5AM=;
        b=J8xx+x98B9piap0gCct2XX4YUS+Rt3oACbQXCr4zuf1K82JyOC7E89lB9Z27Yekn6+
         bRzGUbWJYLp/fuTEino5hePjTRc62K8+K2QqXpCAxJvsxsRonhqYyqrOyqYQVgfm3k29
         kSxHp27Q6G24T6yBXVFjfvbtMUSlt0YNvzvkQqygXA2IxKNqy/gSBNafBgTNu6NHzn25
         Sni9O/zS39eXvOD2fU0mu9z4ubv02jO6atas8o8DFuro/+Wg7XcoL3NpcyZfd5Q5dE5N
         /Okt0t85AtOESiIjPom7/UcPBPF6lvCVCo8KZIOSzazlI6YPAELNryDhVfgKrneTz/te
         MAaQ==
X-Gm-Message-State: AC+VfDwfmY5yEeBr+FFuwMIBXzhQ07/QZR7saybtILm05DEHbdrgtulx
        StdJ3CQRrPCYHU+LFqCJ3LY=
X-Google-Smtp-Source: ACHHUZ7WET+WmkMpPUoY8hHr3ctbsB7VZR4XgRJSxSI7MVpCjUrl1MDNzUDd4rg5gDqwxFhEO4epkA==
X-Received: by 2002:a05:6a00:2405:b0:641:d9b:a444 with SMTP id z5-20020a056a00240500b006410d9ba444mr28862471pfh.31.1687794339974;
        Mon, 26 Jun 2023 08:45:39 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id i9-20020aa78b49000000b00666e883757fsm3984833pfd.123.2023.06.26.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:45:39 -0700 (PDT)
Date:   Tue, 27 Jun 2023 00:45:37 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar: use proper naming for R-Car
Message-ID: <20230626154537.GA2019715@rocinante>
References: <20230607204750.27837-1-wsa+renesas@sang-engineering.com>
 <20230624132228.GA2636347@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624132228.GA2636347@rocinante>
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

> > Neither RCar, nor Rcar, but R-Car.

There might be one more variance left to correct:

  drivers/gpu/drm/rcar-du/rcar_du_plane.h:

  18-/*
  19: * The RCAR DU has 8 hardware planes, shared between primary and overlay planes.
  20- * As using overlay planes requires at least one of the CRTCs being enabled, no
  21- * more than 7 overlay planes can be available. We thus create 1 primary plane
  22- * per CRTC and 7 overlay planes, for a total of up to 9 KMS planes.
  23- */

For the sake of completeness.

	Krzysztof
