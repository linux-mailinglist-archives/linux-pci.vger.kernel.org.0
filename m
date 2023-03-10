Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5C66B4B7F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 16:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjCJPq3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 10:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjCJPqH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 10:46:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0388142DF4;
        Fri, 10 Mar 2023 07:36:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A4B06195A;
        Fri, 10 Mar 2023 15:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76974C433D2;
        Fri, 10 Mar 2023 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678462561;
        bh=eocwuPdCsVWGvPc6VQ56vVCKBc76SEth8nBHmZ2C/Uo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JrS2AvyXrdorxZZfkI+xqUvIBS+Wj3IN8QkU1/1VGBt/OLkPjLFoHuYQc/8qvEFIv
         1OU29JhALx6gnDEduBmcOcPq49Gk/bUEU2aBaTp9M8io7eRHBUKnswXkl/q71xYweX
         l1fiHovuzj0u5H3qTo5engr3FXDZfWIlg9ujglae8YZjj+7FH/s549hJe+1GIfoMpm
         ELnpI2J6s2ZPSzV53rIljpIRkIyi4boDnaA4prwhPUY7JsbNVaFvU6aYVVSsYUphey
         kLlkjLLbQBk0sAy72Njoa3LD3gozu+9pYQDyjUwGH6qsFBQpXLF+KxLiOOpjwxPpAj
         HthLx8pGjfZ0g==
Received: by mail-vs1-f44.google.com with SMTP id d7so5024697vsj.2;
        Fri, 10 Mar 2023 07:36:01 -0800 (PST)
X-Gm-Message-State: AO0yUKWy/LSIuRMn5HIMdUVu2haqLuPnUH70AtxRiwFcllUztY7JoGpl
        adAqgH2sH5h8vnuJ63hdmKzLGmJPzNW4pnl2BQ==
X-Google-Smtp-Source: AK7set9c7LFeBtAIjlwjjDiI+3MJ1/rKMC+jLx5UrviQ8mmOGMywmd510314M12CPjMXgHcbcmSNSgv029VmYJnELZw=
X-Received: by 2002:a67:c516:0:b0:41f:5200:62ea with SMTP id
 e22-20020a67c516000000b0041f520062eamr17597556vsk.6.1678462560432; Fri, 10
 Mar 2023 07:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20230213180735.42117-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230213180735.42117-1-andriy.shevchenko@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 10 Mar 2023 09:35:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+cpkQNfmPCWipKg+nuy9yynuCcNGNBpUD6y6y4QeLb3w@mail.gmail.com>
Message-ID: <CAL_Jsq+cpkQNfmPCWipKg+nuy9yynuCcNGNBpUD6y6y4QeLb3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PCI: dwc: Convert to agnostic GPIO API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Mauro who added all this for Hikey9x0.

On Mon, Feb 13, 2023 at 12:07=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The of_gpio.h is going to be removed. In preparation of that convert
> the driver to the agnostic API.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 105 ++++++++----------------
>  1 file changed, 35 insertions(+), 70 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
