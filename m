Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A090C685E26
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 05:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjBAEGB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 23:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBAEGA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 23:06:00 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13B515C93
        for <linux-pci@vger.kernel.org>; Tue, 31 Jan 2023 20:05:59 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mc11so25200584ejb.10
        for <linux-pci@vger.kernel.org>; Tue, 31 Jan 2023 20:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DxIrbstbVGV0WSYJYE824WT0tnnS5nLForrSr23wb2A=;
        b=HCQa4leFtQ/XFq29iYvXAdzYDUg9SWkTDVGISiXvkxbYkFYteX3QcaDZ+1DEwe8yVQ
         vwYUkYv1AJas8aTPUB9z9cJjj1m3VegQW7XHTOOqiRIxMHl9MBsEGQNaefQk0I2kes60
         9lfjLikuXlTRhD2NN6290bXTdNtKgYmB0j2s/xl8VmrBIZe9D8JpYjckwr9/wWEIHmml
         DwJ3AGYNZhlKBsZVr1VOtKou9cV0W2JKZ/LEnZBylc/J25xEpzQp2y/Rg2CnE3fbmUfu
         A3+zlw92QvDfJbsMa/yxxDTy+qeFbBFFxXTpP1EnSVyuFAU1ey8kiL8WwnsUcs9FJzi/
         4MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxIrbstbVGV0WSYJYE824WT0tnnS5nLForrSr23wb2A=;
        b=sQHzZLbJduYi+KE25LqWW3IHaXG+7ufPUExIUlEaiQ05xUCPXxcKBJg3ojsyVtwsvD
         jhL9PabOKuttx0n9f3cphQSvIDqv1+s1qD6WM/MdLWhUOv203eHyDQqbDC3jvAd2efKe
         ZK4ympC2yEBVwMQuRCZV7YvGg5Kr2qKeiUQmc0H6We28WkaeyOt6cSLp2/la5uSzNxaH
         cwLuQGh4WuvPsgeJKk0VHzVxAns6fHsXuN+bf7EskNncRPaLZXHpSAlhgJBvcE6ZPJp/
         F484kTXPg8UqtmHk1fjroCzFi4twLFpAXB07PLomXVYTUXT7fepu1+sFWzjnZXUU9a8r
         3FiQ==
X-Gm-Message-State: AO0yUKUPprIllAMY4ZcfKnmF9rRNj/dccDaWabfRmM7/fPnzZ1dS8emz
        M9jFNihl5y9GNv3UsVoA6K1U6XkzP26gkbGZrSM=
X-Google-Smtp-Source: AK7set9suTfsg22dP3naum5JKb+9crK+3HOornQytcR6zn3hCyPahDOTV1CJtHb7H22wqAvI8s/kYasi8ooF2WWotKY=
X-Received: by 2002:a17:906:d052:b0:88a:4a5f:ccd7 with SMTP id
 bo18-20020a170906d05200b0088a4a5fccd7mr232137ejb.94.1675224358055; Tue, 31
 Jan 2023 20:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20230201023803.660469-2-chenhuacai@loongson.cn> <20230201034238.GA1824609@bhelgaas>
In-Reply-To: <20230201034238.GA1824609@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 1 Feb 2023 12:05:46 +0800
Message-ID: <CAAhV-H4EwB8Otq4Fa52ga32QHP_SJTVc12=1r+7wG9Z0ZBEykg@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] PCI: Omit pci_disable_device() in pcie_port_device_remove()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 1, 2023 at 11:42 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Feb 01, 2023 at 10:38:02AM +0800, Huacai Chen wrote:
> > This patch has a long story.
>
> Understatement of the year :)
>
> > @@ -501,7 +501,6 @@ static void pcie_port_device_remove(struct pci_dev *dev)
> >  {
> >       device_for_each_child(&dev->dev, NULL, remove_iter);
> >       pci_free_irq_vectors(dev);
> > -     pci_disable_device(dev);
>
> Interesting.  What I had in mind was keeping the original
> pcie_port_device_remove() unchanged, adding the new
> pcie_portdrv_shutdown(), and omitting pci_disable_device() just from
> pcie_portdrv_shutdown().
>
> I haven't thought about the implications of omitting
> pci_disable_device() from the .remove() method
> (pcie_port_device_remove()).
>
> Just pointing this out quickly before going to bed in case you have a
> chance to think about what's the best strategy :)
Sorry that I misunderstood, V4 will be coming quickly.

Huacai
>
> Bjorn
