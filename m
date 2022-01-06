Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B013C486307
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 11:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiAFKiY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 05:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbiAFKiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 05:38:21 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB24CC061201;
        Thu,  6 Jan 2022 02:38:20 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id bm14so7749256edb.5;
        Thu, 06 Jan 2022 02:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8QiEGlS9RbAHPZPertJp45WitjJJ2azSVWAFrREGn0k=;
        b=d8X7dfI+kipLtVbO/9QyKBfgdO8r26tupBM27TUd9IYRN0jnLL3AXHJRJzllfePkTb
         NOGG6mOyzv06fnPaNv33PW3XX94bWtUohlh0QiTiK3bxVGHwEcFXOY2q6Xm0B9bEq5Rf
         C9y+RMv2JO8l/mW92Eo3k7Ih7Vde7um9jg8Z4zdo6tAACKI7MZK/cZCGt0ANLfiCHBka
         Gp46x/WgxUnkfPlQcHJScFMrzNv+++C/bvZ+0S207peq1IdOsMRbWRgZASSb0pmvdDq4
         5u0y6XOL3OtDwcIVy7qgb5qma/ouuXauvnyPMa8T4+yNKnKi9ghBG8XkyYpC3n76EGx6
         /enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QiEGlS9RbAHPZPertJp45WitjJJ2azSVWAFrREGn0k=;
        b=wghK8A068EOPy9YuyJvSedZ7w2hTXzQErGwzuw7AGajMLYLfEToNwbDEPljSlbEanU
         iR4AsS0CdA0dYPdKdDkjBcx9QGn8oVR7dmgWbqVE5jmDWuQ0qsH2QcBWyV7uVFemHIh8
         ULT5iAavefZz347H1LWTCFXS2wDypTSF887Oh5IwHWLavSKbQb6qYOvGGXEZNQsnlVEI
         ebuu8G5pFNFvSxJ3kI0BRRZIO+V8u1cZMSaTC6Tk5UF0CWA/kW29KIZ9E2v8DojG8wXf
         1XJQ39QDHgGlAka9YI/0nGaQeNw/jTysUW9k3QpPXVbNC/fvyrWvmCxJWjHz8zF63Liv
         Gdyw==
X-Gm-Message-State: AOAM532skVgaMopQDbkGf/OP4c5o6aCPawXOwtbTmFSLvOOgtKtki3fj
        dIcg6p6NpQuaS5/l4LLqMpeZd8K1/x0rpSJA1m4=
X-Google-Smtp-Source: ABdhPJwxnzUBodto09qprmOrgp3b2tSvw7CTQdMvRlHLszbjpSJi5DLiwMBnMQE49zj6kp8XGKeMNfY68Stb6DeZb4E=
X-Received: by 2002:aa7:d547:: with SMTP id u7mr56510856edr.76.1641465498879;
 Thu, 06 Jan 2022 02:38:18 -0800 (PST)
MIME-Version: 1.0
References: <1641368602-20401-1-git-send-email-hongxing.zhu@nxp.com>
 <1641368602-20401-6-git-send-email-hongxing.zhu@nxp.com> <CAOMZO5AqgOOo3+r3yQSsfaNxW9eHXhCi=m+mqR=sf=K6dXA8tw@mail.gmail.com>
 <AS8PR04MB867662FF5FC56A7613D509CC8C4C9@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB867662FF5FC56A7613D509CC8C4C9@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Jan 2022 07:38:07 -0300
Message-ID: <CAOMZO5BY7BYQKqEgwj2XA-B-oCHbb2LFG8Zq1e4ca=sTb4=ceA@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] PCI: imx6: Fix the regulator dump when link never
 came up
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

On Thu, Jan 6, 2022 at 12:49 AM Hongxing Zhu <hongxing.zhu@nxp.com> wrote:

> How about continue proceed your previous fix firstly?
> https://patchwork.kernel.org/project/linux-pci/patch/20211104000202.4028036-1-festevam@gmail.com/
> Then, I clean up the fix patch, and re-send my series later.
> Because that I still want to save power consumption as much as possible
>  when link is down.
> BTW, please remove the timestamp in your patch if you agree this method,
> and resend your patch.

Sure, this sounds good. I have just sent a v2.

Thanks
