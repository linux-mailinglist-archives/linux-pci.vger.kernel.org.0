Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03031A466C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 14:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDJMke (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 08:40:34 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:34685 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgDJMke (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 08:40:34 -0400
Received: by mail-wr1-f53.google.com with SMTP id 65so2203324wrl.1;
        Fri, 10 Apr 2020 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=rm/s7Of5tyiM3zBV6IUST0jMSM8VLFZiHF+K3kYVCJw=;
        b=BSJ/l1PudXUHxgJ3jPBzuENUygdCyWz27ohvFWFDHoudALwA8wTcuI5Ws/mJRKjfxQ
         KFy7R/fm0FmiatMUVZXWmsawe/WcZAfp/idX+z6VtOU1J6LVqtUcR47/Lsa8l7wjJA2l
         ihXQmWDe8APPC3O/Cr9rqdUG4npr5CR7dl8xxz+8foS2Wr3DK5J3Ff3JVJwEkE4LUbk9
         t6W2pHthVbNnMC9NSWxpePgw8YS2GPvqiViBpaCpuZKH0Q3WY2+wdfltfN03fEvxpr8C
         75eChcP6epNvkEx36E4bQ0mYPvknBJGhQXVy58LF7Gb+CIuVcqJleT/RAiqbhm5enxUh
         fUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=rm/s7Of5tyiM3zBV6IUST0jMSM8VLFZiHF+K3kYVCJw=;
        b=XXmMXw4N9PqEkXB8OKd4tqdD9nnTtidOyVasMok6xZBTtvEj95kQxF9CWokJ/9Ch+Z
         kg2FPP9l+j2O6iQV210aOIMnSnb3uQYztrJOw3Ui453aW4Ynskf73qlkDShkpv9c7faN
         7j35/Uia2Ez27Ya9ettaFLi2s77HDDnogBHk6Cr79HHafLR6b5EtHWnWPGwP3jp5ke8U
         6zbGRlZs1dL4tOG75y7MgER1bAsH7HmGIY3bh1dFSv1HtuhD2XW4UiuR+oMHuTnlrcSp
         lRtW0CXfCbIkFsczqXiJJmhpipJpkqiHBmQJQUVk6+givdk+WbzEdEhVObOUzM17mxXg
         CEZA==
X-Gm-Message-State: AGi0PuaO7Q9LljRGheDrSBHV0Oj1REVwNPTPwmw4KBFxEF/xmOnkK7Pv
        QYPDUhv02BCisKBul2AgYmk=
X-Google-Smtp-Source: APiQypKRraFyHTo4V8xqIzuuT41OSHDs2OlgLliaDYIUobI3879HHQGLibiZAYUnd/WQxF4++G+kvA==
X-Received: by 2002:adf:fecb:: with SMTP id q11mr4590057wrs.350.1586522430447;
        Fri, 10 Apr 2020 05:40:30 -0700 (PDT)
Received: from AnsuelXPS (host117-205-dynamic.180-80-r.retail.telecomitalia.it. [80.180.205.117])
        by smtp.gmail.com with ESMTPSA id k3sm2642805wmf.16.2020.04.10.05.40.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 05:40:29 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Fabio Estevam'" <festevam@gmail.com>
Cc:     "'open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS'" 
        <devicetree@vger.kernel.org>,
        "'Richard Zhu'" <hongxing.zhu@nxp.com>,
        "'Lucas Stach'" <l.stach@pengutronix.de>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Shawn Guo'" <shawnguo@kernel.org>,
        "'Sascha Hauer'" <s.hauer@pengutronix.de>,
        "'Pengutronix Kernel Team'" <kernel@pengutronix.de>,
        "'NXP Linux Team'" <linux-imx@nxp.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        <linux-pci@vger.kernel.org>,
        "'moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
References: <20200410004738.19668-1-ansuelsmth@gmail.com> <20200410004738.19668-3-ansuelsmth@gmail.com> <CAOMZO5AKYO3xLsp4k6_fJCV9qW=rAtRKEGWnxksixU794dOw8A@mail.gmail.com> <003401d60f28$3d045190$b70cf4b0$@gmail.com> <CAOMZO5B+rEoQD_ujt9cx9VXO-i2oqfW2UN2cVeB5hZB3aVpGeQ@mail.gmail.com>
In-Reply-To: <CAOMZO5B+rEoQD_ujt9cx9VXO-i2oqfW2UN2cVeB5hZB3aVpGeQ@mail.gmail.com>
Subject: R: [PATCH 2/4] drivers: pci: dwc: pci-imx6: update binding to generic name
Date:   Fri, 10 Apr 2020 14:40:26 +0200
Message-ID: <003401d60f35$3725b630$a5712290$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQJxOzeYiZkD8UITQ1/aTwnouqE5vAHrEXcAAuDSQDUBZHmnXgI2W/cjpvi8vAA=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Hi Ansuel,
>=20
> On Fri, Apr 10, 2020 at 8:07 AM <ansuelsmth@gmail.com> wrote:
>=20
> > so no chance of changing this?
>=20
> Reading the commit log I don't see any explanation as to why you need
> to change the current bindings.
>=20
> What is the motivation for doing this? Is this really worth it?

It's really to not have the same exact binding to 2 different driver.
If this would cause problem I will use qcom,tx-deemph...... but still it =
looks
wrong to me having this. How should I proceed?


