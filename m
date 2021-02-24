Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0412D324104
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 17:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhBXPg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 10:36:57 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:38310 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbhBXO0H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 09:26:07 -0500
Received: by mail-wm1-f51.google.com with SMTP id n4so557064wmq.3;
        Wed, 24 Feb 2021 06:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yNOTeF74AEVCmwolAA0/8VTyL+nE8bLyKqVdo+FWMqY=;
        b=hK4+NygG1uT+ASYbGOVKdVkNg2OkhfSOpVkF3l6MiqRDlOM0+gcS+ETrRhXO/Gn5WE
         sUKy0HHUvxZ+5S4KHr0FVNxFb6y/dHf5bnp9uniBymMq86wO/rGYxsE46ktxpp/w6gTW
         BHX81cud8/1kyDQ2aBYLyVukLf2MUvrKJZ/ysAnuj867tJwG49nl6/hjytSBaxazstCj
         MozmgNt0MxmRvXNMSC09/N2rbbGitr4H9kaTi/t5V1zkHu1Y5sIlFahce2o0pkpKC4k7
         rutG2YqXNUfL4g4Bu6k/wSBH53xTyo2PzwhZFc1u6FT0siTPEzH9LFiBkHBRrCynrcim
         tXAQ==
X-Gm-Message-State: AOAM533+I4kh8ts6JHuvrs5nYHb6EGL1V0hBDWrRb6phJkEyPVKRsSqI
        L0VTHI1xtLzWfAqHnTim7rk=
X-Google-Smtp-Source: ABdhPJxfrJvj1Nu7atjaQwkrtJNZuIvIcIcghN5f788Gg2oxt+yrdZvub8CkWecyTONsxU0eMBnWow==
X-Received: by 2002:a1c:e041:: with SMTP id x62mr3285059wmg.95.1614176701475;
        Wed, 24 Feb 2021 06:25:01 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j16sm3898710wra.17.2021.02.24.06.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:25:01 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:24:59 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, maz@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
Subject: Re: [v8,4/7] PCI: mediatek-gen3: Add INTx support
Message-ID: <YDZhuwbgdUsnBD/0@rocinante>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-5-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210224061132.26526-5-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jianjun,

[...]
> +/**
> + * mtk_intx_eoi
> + * @data: pointer to chip specific data
> + *
> + * As an emulated level IRQ, its interrupt status will remain
> + * until the corresponding de-assert message is received; hence that
> + * the status can only be cleared when the interrupt has been serviced.
> + */
[...]

See my comment about the kernel-doc from the following:

  https://lore.kernel.org/linux-pci/YDZWUGcKet%2FlNWlF@rocinante/

[...]
> +	if (err) {
> +		dev_err(dev, "failed to init PCIe IRQ domain\n");
> +		return err;
> +	}
[...]

Just a nitpick.  What about using "initialize" in the above?

Krzysztof
