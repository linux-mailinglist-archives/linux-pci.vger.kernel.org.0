Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC1D4AE6C4
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 03:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbiBICkX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 21:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244139AbiBICBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 21:01:48 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13150C06157B;
        Tue,  8 Feb 2022 18:01:48 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cf2so2103191edb.9;
        Tue, 08 Feb 2022 18:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWnnC6X/3LfUNvFejjOf/o+BhqQPL36rKux7esaUqwU=;
        b=k3O5GQanRHIEkNhPqjnOuYe6aHao9DnrKOReuSxBQnvFZ+7kJ4ld9HSkvPcFdLwXVo
         yqyNAC6PYUb5K1s9oF/yXHBqJWt5s8dAv4PwGG7HwiQ3+yU/5z7ctjiKMb+YfWclAgOk
         wU8hOcidH7oOlj8TmXjkOAkyEVb/QvNxx/Jw4B7hQUhRLGE+Zdm/P04KUdc2WX9GqjAo
         Qd0fT4gwCm9V3gMCL5qpAJ1+ctAa9xhVf4cIgk2S+6JXY9WgxlVOYPiKbpK8IUfAqJxq
         JSfnQH9dls1YYKs/Z4yMwuA/NcdqMWfa/RpzfkILKLIjXM1U7nglBYZqBSmNb0XG47bJ
         YhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWnnC6X/3LfUNvFejjOf/o+BhqQPL36rKux7esaUqwU=;
        b=p7aBBjOrrzAFPKHDDtSbHGAbb4gmBD43BPx/twURg24jDZsllQA359XLBZk68RkBKv
         YV24kzNfX2Tu3peia4DZ50gV9q4NGoxisWSBM2sLJb/ahImRkB+rktG89LDzSoO7fE2d
         7nn288CGfOFuJGTAjygLmSGdxIhUB7okhSgsBAUO2Ft83yUTo5q/Rxe3kD8p5zrf0yqQ
         IZLTKaU6rjZw071WdNzxxOzqzh7vX1O91yxKx40wbhoD9ilxsJ1lh3rdWhHkPhEYMtFa
         HhxS0x1dEAjpl4HMa2JUUUXoYkiFz1QzRB1BGPUkcDmA4+kz2EH2soWo0ajGLKFfBYzN
         T0zw==
X-Gm-Message-State: AOAM530Aoi5HctSKIvi5PK7+w6JBjXEFYCx6zFXrS+2cCsNGe07X6Pc8
        UUsNQgpV37liodgF2vg8hdF9y776V7nNd9S5zbk=
X-Google-Smtp-Source: ABdhPJwuNUoPvXQy2DbyC89NZT6PfpXs+807StThbTX6vEtShDzyDKiD5rl4tnx5cTsfI98LYMsM7moX2a/KWHAlsZM=
X-Received: by 2002:a05:6402:440a:: with SMTP id y10mr199806eda.215.1644372106542;
 Tue, 08 Feb 2022 18:01:46 -0800 (PST)
MIME-Version: 1.0
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
 <1644290735-3797-8-git-send-email-hongxing.zhu@nxp.com> <CAOMZO5ALthc7zZEYZX2YHam2f3C1RmOr4CHLRjHSip7-44tL6Q@mail.gmail.com>
 <AS8PR04MB86768828ED6B984C674CE2298C2E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB86768828ED6B984C674CE2298C2E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 8 Feb 2022 23:01:36 -0300
Message-ID: <CAOMZO5CUbY_SyjDpnFd-EPy+K+MYA6nn=hk_XpZnAFdJP53CFQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] PCI: imx6: Disable enabled clocks and regulators
 after link is down
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

On Tue, Feb 8, 2022 at 10:56 PM Hongxing Zhu <hongxing.zhu@nxp.com> wrote:

> Do you mean that we should ignore the return of dw_pcie_host_init() and
> finish the _probe without an error return?

Yes, we should not return an error on probe if the link is down.

Thanks
