Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CC64498C6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 16:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbhKHPzc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 10:55:32 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:39510 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbhKHPzb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 10:55:31 -0500
Received: by mail-lj1-f181.google.com with SMTP id t11so30380520ljh.6
        for <linux-pci@vger.kernel.org>; Mon, 08 Nov 2021 07:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E0F5Onblgfh+hTQ7up79bIDtJeB0teDKjpuol7uq/EA=;
        b=4JN38JQ3YBg/To+PpKBMlnWgL66p21DnE93gbaOBbWkBykT3pyilRlT3Jq6GCeQz7j
         pBm2UzFCHoWNcmZ2amIY/aZjwa2/8cNOMAwbaFDstE9Ukve6vykuNE+MVQm6yAY5+OmW
         NYJJ9eFNn0CZgrn8pMZaX7w/d7WjZvIs1iZj9py/wT1KOB/NPTZR5sq3echhBY0LQp3o
         p+Trw4d8mtEgK0whhWVdusN7PuFyG7QPPX54+H1LKgC8mObiTaGKxJc8Srfd9e9OPCtU
         Ph4VdyRG6w5BbpMYUdYaLZskH4WMenB5RuviySQPrclQVdKxXqJJ3cxpEyFYXGiAp8i3
         rgmA==
X-Gm-Message-State: AOAM532qoWpTEFh7D1RMtmRI2M+OQdDlYcXTuhXfyzdBnnKJsny+ZvAs
        ymM/tUxO/YyXaV1enPhJZli5Z6zX4CntEgpq
X-Google-Smtp-Source: ABdhPJxaKGQ6wmr7NL1saDbAGoy4zj7BN4FjL2UXNdC0ccOd+U/mL7ZTVymd8wV/GKj57dtUPdkUCg==
X-Received: by 2002:a2e:9dc8:: with SMTP id x8mr12607ljj.502.1636386765659;
        Mon, 08 Nov 2021 07:52:45 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id m8sm205531lfq.27.2021.11.08.07.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 07:52:45 -0800 (PST)
Date:   Mon, 8 Nov 2021 16:52:44 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Fan Fei <ffclaire1224@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Distinguish mediatek drivers
Message-ID: <YYlHzMGAdO1eOQLn@rocinante>
References: <20211105202913.GA944432@bhelgaas>
 <98d237693bc618cba62e93495b7b3379c18ac6b5.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98d237693bc618cba62e93495b7b3379c18ac6b5.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> > Both drivers are also named "mtk-pcie" and use the same internal
> > "mtk_" prefix on structs and functions.  Not a *huge* problem, but
> > not really ideal either.
[...]
> Thanks for the reminder, I will send patches to update these entries.

Perhaps a silly question, but would it be possible to combine both drivers
into a single one that handless devices across all generations?

	Krzysztof
