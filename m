Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3EE320D2B
	for <lists+linux-pci@lfdr.de>; Sun, 21 Feb 2021 20:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhBUT3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Feb 2021 14:29:48 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35463 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhBUT3q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Feb 2021 14:29:46 -0500
Received: by mail-lj1-f171.google.com with SMTP id a17so52047789ljq.2
        for <linux-pci@vger.kernel.org>; Sun, 21 Feb 2021 11:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SQFiq6DDN/SxkW/ohlkqHphfIUHTGypAJ815v4LoWb0=;
        b=j6tpH1i5MW5u1aWR9jfsNAjXsYF4wmqSV/+9oEGXbwI4ARrBXniFI2poTCfEu+T2xg
         zu7B21XEwTRRk6W/tgZjrWWS032cPhUd+yWQjJhHa46Ts8Ap3GekHHpttflrRDcP7UvE
         50rb0CF8akzH0jy6ZxEv+ACo3+ZPmDVguh5fcNn1D+KAHqOiMltN8dPl/67BsNs2JnVs
         7gjOuDF4G8tGlxMy956ScEidDVo2BVEzf+GM12WI89F9dV2PoELZaMB+6Frs89GMPfDb
         ylJ3xAh6wyIyEms0FindtegqyEOlXs2N1gNgS5PhRPLl1LWQ5/BbBiQw6ZnCgOHcpp9a
         kUpg==
X-Gm-Message-State: AOAM531QlEc7FqxZGXw1BkyZOF3vqhz/vx84mBVQ3oJYMpW2kSIUv40C
        oAV+GP5OS8tAyrEIU7jCAhs=
X-Google-Smtp-Source: ABdhPJzEbbeu0fbOev1XlPyOYD2DYPIjQcoys0e400+VdE5MQpJrqN14HwH/8s7yvbBL3objVQrxPA==
X-Received: by 2002:a05:651c:110c:: with SMTP id d12mr11837357ljo.350.1613935744971;
        Sun, 21 Feb 2021 11:29:04 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 74sm1649404lfo.268.2021.02.21.11.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 11:29:04 -0800 (PST)
Date:   Sun, 21 Feb 2021 20:29:02 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] PCI: mediatek: Configure FC and FTS for functions
 other than 0
Message-ID: <YDK0fr/UiKjit+ty@rocinante>
References: <c529dbfc066f4bda9b87edbdbf771f207e69b84e.1604510053.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c529dbfc066f4bda9b87edbdbf771f207e69b84e.1604510053.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo for visiblity]

Hi,

Thank you for taking care of this!

[...]
> PCI_FUNC(port->slot << 3)" is always 0, so previously
> mtk_pcie_startup_port() only configured FC credits and FTs for
> function 0.
[...]

A small nit.  The commit message is missing the opening quote, see
Bjorn's suggestion:

  https://lore.kernel.org/linux-pci/20201104131054.GA307984@bjorn-Precision-5520/

But, it's probably not worth sending another patch, and perhaps either
Bjorn or Lorenzo could fix this when applying changes.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
