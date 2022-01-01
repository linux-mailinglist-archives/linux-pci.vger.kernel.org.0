Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6320C48274B
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jan 2022 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiAAKj6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Jan 2022 05:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiAAKj6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Jan 2022 05:39:58 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A240C061574
        for <linux-pci@vger.kernel.org>; Sat,  1 Jan 2022 02:39:58 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id v25so25789527pge.2
        for <linux-pci@vger.kernel.org>; Sat, 01 Jan 2022 02:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=nsyuuLHWWRWkWlMeFbsZuMY5+2USOxq27rUE/m6WuEjasT4nrGI0g/ICdZQqyzA1Pw
         8EeRWCIK+lJhX/oZwnMyG9XPTItYdu9pvW7RwjCWyw0z54aIJWe48X7UNqu/wo9ybm5S
         JpluyRE9+7aUxgCXCXFl/j8LYfr5Dn4X913DMTcU9nxijTCIu7RRp/tc7VDPIYK6T9fx
         lnvzhTEosAtPb14drp6j4hhgmhpsDtATcXtnEJ1D8hXGoiFnQJIR5NMSHYJT7JcM/Csl
         9founN94f4Fakg7k1tvcvDV9g5sIl0OhjSSVcJw8QIGFmI8CwvgQAPCDybvsyIRfLNUi
         DOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=awOh0sCQJI6yfMEG3T3kQAEppglOmInjamNARbvxVKKian8Hl8YIWQT888yWFiZdZb
         jhCc4kwWJj3rSLr/v/OkaXowqVfkb9vziknzxhAS1Bm484qYIVTKZBdlklFWoTw3+Odl
         SGMrCyta+T9FtMqCkFLbnRn72bYAUFZfa0QDTBYfj63k6sT+mZSSJIfwmWJLb6C4KKPE
         v/0MdGJLQ7Ma7huAO+FNoVAo9thXNuP02rLB5GWRi8GxTsJqCf35O95Ode00wRcIM37Q
         6KCmwDiuXAtKY/bWIsfd4UE0ktxfe4sanFkXouJjCqyCADHZbigLEnbnsHVRoEeKw8ob
         qV3Q==
X-Gm-Message-State: AOAM532JHePI80Xb/V50HuTsYETPrw5Le/PDkGOoQuk6fHaKszLV2oKa
        0kYEpBZ53wPuD3R6aP02vCU=
X-Google-Smtp-Source: ABdhPJxACADoeO3+9o4yEgi4/mNwB/1MOs+3N7pX7OEJvRvYulePvumO67Yta6tdmwWOUVpj5k6WPQ==
X-Received: by 2002:a63:35cd:: with SMTP id c196mr24900808pga.623.1641033597900;
        Sat, 01 Jan 2022 02:39:57 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id y21sm26951019pge.41.2022.01.01.02.39.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 02:39:57 -0800 (PST)
Message-ID: <61d02f7d.1c69fb81.e1353.b67f@mx.google.com>
From:   hyaibe56@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 12:39:42 +0200
Reply-To: andres.stemmet1@gmail.com
X-Mailer: TurboMailer 2
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I want to confide in you to finalize this transaction of mutual benefits. I=
t may seem strange to you, but it is real. This is a transaction that has n=
o risk at all, due process shall be followed and it shall be carried out un=
der the ambit of the financial laws. Being the Chief Financial Officer, BP =
Plc. I want to trust and put in your care Eighteen Million British Pounds S=
terling, The funds were acquired from an over-invoiced payment from a past =
contract executed in one of my departments. I can't successfully achieve th=
is transaction without presenting you as foreign contractor who will provid=
e a bank account to receive the funds.

Documentation for the claim of the funds will be legally processed and docu=
mented, so I will need your full cooperation on this matter for our mutual =
benefits. We will discuss details if you are interested to work with me to =
secure this funds. I will appreciate your prompt response in every bit of o=
ur communication. Stay Blessed and Stay Safe.

Best Regards


Tel: +44 7537 185910
Andres  Stemmet
Email: andres.stemmet1@gmail.com  =

Chief financial officer
BP Petroleum p.l.c.

                                                                           =
                        Copyright =A9 1996-2021

