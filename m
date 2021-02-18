Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE731EF49
	for <lists+linux-pci@lfdr.de>; Thu, 18 Feb 2021 20:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhBRTJU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 14:09:20 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:39332 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhBRRfE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Feb 2021 12:35:04 -0500
Received: by mail-lj1-f178.google.com with SMTP id u4so6588321ljh.6;
        Thu, 18 Feb 2021 09:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+H5vXg85aSm3kKn9ABWRfBsJH0MBve5XT0w01S84ZnA=;
        b=qeBjF9FaK8ywxhhZy7dT8jsUL3y3Ish6j5VUAHUJKYGCvljvKN9OuaA+ZxZ1l1Krk9
         3iV7SvfUelZKx+H7HuOZKsCus4DZNQuh1JJ/bYTNXWN0JoOkOvdH4d5dHWY25qMPHr4O
         O5C+apO4ztUKAxzuzRTcyb0skjK9tFX6TNBKmRljy+CRbIx0dUnidjTtm2yOKMudJA3n
         hRYSQfrNPOhy3vrXXvojdLSuuttF4IH3zkD9Bam/yMddJTNOEt3Fbn8tA9XdpCPm0hM1
         OSH/S5lTx9eAMuvpnzLafMzPpl+rKfdMC9eOdkK8kRfHIJJ7Gs3QvzgBR5kazfrV0hAv
         GXKA==
X-Gm-Message-State: AOAM5309T5kqtpz6SBt55dcnhcOrZAZsQLfn+F4mmviI0ht8VqtL7aya
        T5teVMJMucat9oKRafi7uis=
X-Google-Smtp-Source: ABdhPJwl/ulks4iH3qRkRAtn+ihuBahk7zBSXH3/5QASJOyrDU/f5gUKrALLJoY/y819thiC3X6DmQ==
X-Received: by 2002:a05:6512:3092:: with SMTP id z18mr2875307lfd.249.1613669646944;
        Thu, 18 Feb 2021 09:34:06 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u9sm181117lfn.138.2021.02.18.09.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 09:34:06 -0800 (PST)
Date:   Thu, 18 Feb 2021 18:34:05 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, helgaas@kernel.org, stefan@agner.ch,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] PCI: imx6: Limit DBI register length for imx6qp pcie
Message-ID: <YC6lDYG13DhIppmW@rocinante>
References: <1613624980-29382-1-git-send-email-hongxing.zhu@nxp.com>
 <YC5VmRTIylDHSFPt@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC5VmRTIylDHSFPt@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[...]
> > Refer to commit 075af61c19cd ("PCI: imx6: Limit DBI register length"),
> > i.MX6QP PCIe has the similar issue.
> > Define the length of the DBI registers and limit config space to its
> > length for i.MX6QP PCIe too.
> 
> You could probably flip these two sentences around to make the commit
> message read slightly better, so what about this (a suggestion):
> 
> Define the length of the DBI registers and limit config space to its
> length. This makes sure that the kernel does not access registers beyond
> that point that otherwise would lead to an abort on a i.MX 6QuadPlus.
> 
> See commit 075af61c19cd ("PCI: imx6: Limit DBI register length") that
> resolves a similar issue on a i.MX 6Quad PCIe.
[...]

If you do decide to send another version, then also use "PCIe" in the
subject, rather than "pcie".  I forgot to mention this in the previous
message, apologies.

Krzysztof
