Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5BF60E1B0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiJZNNS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiJZNNH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 09:13:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA67100489
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2022 06:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA153B82253
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2022 13:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669E8C433D7
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2022 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666789976;
        bh=ACK0tKgSDk9fpuotvyXYPk80MnYakewXYP4giZeHZIs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uXvc59Dn+xsDsgChCOws9mAW7p6R6hr4PW6PtEl2iDj28Om2ZkMN6TEGJEjpgJYvV
         eZdAhX+NT7LVoaAlM/kC7CNVQCOCcl4CTGFqw1HnsM66wpVlcYfABfWaPdaFTNhcNY
         5Rgfiv0KJTU51SbiXRmrkAf+Oj3wD0x80tEQTPdPzfoZ0RNwXuuE/zyaRzXVnPPWgA
         Qk4ZWRZq+gAEQiTH6mcF3d4wybtYvWT0zN4WtcPAA2epY0Cd4X/flht4CVqef9IZUl
         tatIhwt4lYfCQv4GSV3aMpCVTF2ff6wN0EMLOGSZPqeuwjcRkNBkD50gqL0WNJlNNo
         +YokbzG8ZTWvw==
Received: by mail-lf1-f52.google.com with SMTP id g12so17937697lfh.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2022 06:12:56 -0700 (PDT)
X-Gm-Message-State: ACrzQf0FUfIl5V3S/9tF6MHVoGKRWhj8Kuq8e2JrKn2NfAYYMUBltDzH
        K54vvM95qCkLrcZ/t838zfibEFPkKLyTEuNLAw==
X-Google-Smtp-Source: AMsMyM64BqROVmpal1ZuUAP9VxUwDrcxVc++aAjO/aE+dkGlZjWyfRkoZMz0pFj0XXleBoNrYmc9ko9TcHCr37SWIeU=
X-Received: by 2002:a19:f24b:0:b0:4ab:cd12:d282 with SMTP id
 d11-20020a19f24b000000b004abcd12d282mr6078567lfk.74.1666789974445; Wed, 26
 Oct 2022 06:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221026015850.591044-1-mranostay@ti.com> <20221026015850.591044-2-mranostay@ti.com>
In-Reply-To: <20221026015850.591044-2-mranostay@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Oct 2022 08:12:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ5cOLXhD-73esmhVwMEWGT+w3SJC14Z0jY4tQJQRA7iw@mail.gmail.com>
Message-ID: <CAL_JsqJ5cOLXhD-73esmhVwMEWGT+w3SJC14Z0jY4tQJQRA7iw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI: j721e: Add per platform maximum lane settings
To:     Matt Ranostay <mranostay@ti.com>
Cc:     vigneshr@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 8:59 PM Matt Ranostay <mranostay@ti.com> wrote:
>
> Various platforms have different maximum amount of lanes that
> can be selected. Add max_lanes to struct j721e_pcie to allow
> for error checking on num-lanes selection from device tree.

It's not the kernel's job to validate DTs. If it was, it does a
terrible job. We have a way to validate this.

Rob
