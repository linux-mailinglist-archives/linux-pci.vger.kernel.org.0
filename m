Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6D139137
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 13:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgAMMpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 07:45:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgAMMpA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 07:45:00 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C7EC21569;
        Mon, 13 Jan 2020 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578919499;
        bh=h2vZy2bWnuOeobfvrsF7bMbPSggmUgSHrXcLvhHe7Mg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N3RX1Ypcowo3Mn9FIQ+pzjVoLwvqsf9arFl1qUMAXxaaBcdYTG68XQGB5xsWms88l
         bbK2vvlRiC2cj4PSYMtcFYZFLLZl55attJdMpDDR0EjvKPv/16uh+PlyAF8EJGi1Bw
         L89YXJbkwfb6hNJvw5cvHzigaJ0zTf/7EMSoS/pc=
Received: by mail-lj1-f175.google.com with SMTP id u1so9872057ljk.7;
        Mon, 13 Jan 2020 04:44:59 -0800 (PST)
X-Gm-Message-State: APjAAAUjIAvw/7sMthibg/MwBf5oaGi/+h2PrRK/FH54gpd1PF7WybUn
        Y2wZeUZaDxS21hHOK3aVtVP9XiCEP2UlvWAMP9o=
X-Google-Smtp-Source: APXvYqwKz1lxjQq9n3Z7zbCk525GAplUZqZxAGOd/qz1ruUmT+zfym4LTKRN/pHQEyDCiubOy3VWR5NbxzECZmZ9BrA=
X-Received: by 2002:a2e:8e22:: with SMTP id r2mr9922935ljk.51.1578919497737;
 Mon, 13 Jan 2020 04:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20200104152107.11407-1-krzk@kernel.org> <20200104152107.11407-17-krzk@kernel.org>
 <20200113122902.GA15939@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200113122902.GA15939@e121166-lin.cambridge.arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 13 Jan 2020 13:44:45 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcNJ5QCabPUh4kcOj_9Gj2SF8+JGtSJu8cLEp0Ciqy96g@mail.gmail.com>
Message-ID: <CAJKOXPcNJ5QCabPUh4kcOj_9Gj2SF8+JGtSJu8cLEp0Ciqy96g@mail.gmail.com>
Subject: Re: [PATCH v2 16/20] pci: exynos: Rename Exynos to lowercase
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 13 Jan 2020 at 13:29, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Sat, Jan 04, 2020 at 04:21:03PM +0100, Krzysztof Kozlowski wrote:
> > Fix up inconsistent usage of upper and lowercase letters in "Exynos"
> > name.
> >
> > "EXYNOS" is not an abbreviation but a regular trademarked name.
> > Therefore it should be written with lowercase letters starting with
> > capital letter.
> >
> > The lowercase "Exynos" name is promoted by its manufacturer Samsung
> > Electronics Co., Ltd., in advertisement materials and on website.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pci-exynos.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> Should I pick it up or you are sending the series via another tree ?
>
> If so (if it is not queued already):
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Please pick it up.

Best regards,
Krzysztof
