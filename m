Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B3E482786
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jan 2022 13:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiAAMOZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Jan 2022 07:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiAAMOZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Jan 2022 07:14:25 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C7C061574
        for <linux-pci@vger.kernel.org>; Sat,  1 Jan 2022 04:14:24 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id n16so21791118plc.2
        for <linux-pci@vger.kernel.org>; Sat, 01 Jan 2022 04:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=h1FZ5l8oR25v/n6BtFGjuQCSsbz0uytfyy8SziFBdCx2Ihp4owEroZQu0WscRJgpon
         pHVJ1Pv8j8pLg8KVgdAadaIGrfXlkYhUKrAtxR8IGSOdERdL8HiXKH/U0Uw2myqL8fNW
         KSzVMM5y8XGtDBaoM0Evhz+Zo+s7mVWtstOTduo9AX1PQ+caJQiJh4xdRilf9jkLNO7O
         YPKOA5zZQY7XLU6m9y9ESm3svTIhFExKzq7bRaFci/wHE7pIFGFsmbWc4RaLLCejzIV6
         M1N5rn7Q5a9+0tOwSwM/oP5GGFCYyk1LvNloWYWH4NXDkuQuHmciGe9LnlpDCStO6Vnp
         W6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=MvDUz8kgfIuVfNe133obgj1nLFHuR/80K35QYALERyTdOYXoQsn12vg6w/00MZ4F/0
         4Y8lgMnNmoBoPra1CtKGufRZ0HgiuN40mqTIkBMROZwS6WliLgKFTjTUDlx045AKKA7C
         vYtCQYsw0rZ8FGFxC8Y/L2VX9vsQ2KeLOeggImI2Vl9X2bRapN7or38Dgurro+bmYEM8
         A3PzSrrSROvDMUpvOxFK2zkNZ29KUvbH+4tFjebX3f9lYJuNaiXKeDNB1bYDbD4giiJf
         oZMCJ6OAPYBs9xwor3KNCeKqK7s9HDQkP0T+mRZT/NgpeFhMvyDnjbK9AiyabhMJma13
         X11Q==
X-Gm-Message-State: AOAM533oyyGER16YHIFHkybFC1L3H8Uc/N0W/mtN0vQ4yF/ql8L1aai8
        fbDBeEwKTU4DShnTL7YZP/RZZr9LK0G+iw==
X-Google-Smtp-Source: ABdhPJyEybWhrElJgmwb4CpoN413u82pJ6+BECxCxRCkeKc8AMUPcaEFcnXN9ozkqzQK05m5Gj9Whw==
X-Received: by 2002:a17:90b:4f4e:: with SMTP id pj14mr46313300pjb.96.1641039264596;
        Sat, 01 Jan 2022 04:14:24 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id x31sm34736025pfh.116.2022.01.01.04.14.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 04:14:24 -0800 (PST)
Message-ID: <61d045a0.1c69fb81.8bda6.d9d0@mx.google.com>
From:   yalaiibrahim818@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 14:14:07 +0200
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

