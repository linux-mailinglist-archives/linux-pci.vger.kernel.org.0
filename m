Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF46B58CC
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 06:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCKFzo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 00:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCKFzn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 00:55:43 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AA2124E8D
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 21:55:38 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id bp19so5906651oib.4
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 21:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678514138;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=o7Z8x9ucZHcPB7d2SzwabPiTEhPvjweRXEzZN1I+ZccUu+4Spz9Hsw60A/s6jgs6aU
         9MFtk8NZnNi3u5XFMyrnzjHJga+AUG6cNq4+VMxnF3Y+LpwsIDXhF8NVDjKFunQuwKDA
         HVfwqbzRQwgMSSknn9/X6Xd640xoryS/GF8QpfxMjQSKzEDlbfAEVJFvmMpDMQPnY0I8
         Dy/u8Tydx9wZXxZGSxaQgvz+ZehMDKDLJ04DGwbm3Y9V4nH6WEOv0Z8wCpJpHg9Q6R9v
         CjSPD+3xNUeT+lSIDK8abWnOcUlsstkGtvdEyYjLaLpL8KN+kyTJAQNjxQBULko2e9mn
         KP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678514138;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=z2cnHQnd6+3bOoOT+u/xC1mHyqkMuvolI+yPAsmdnq1PzjOMxtOZlm9aQemlyAj2dh
         ug5/GIbJrkbk5i2SJndDesMsON8DXitOrhHtCeKLYyxxWB+jVLX82TRfgwlprLIlCgbg
         9Wq+2SoMrgcsViAihDWDZzTYgRUuR27B3DlSNqp5mcxwSnd3Yipzqzv2N83Go1a5Zgu5
         ZGGu4bi5Jbz3TV+kL7a1ukw4oO3hfXCHSRD7XN9W7M3tV6BK+ZtbkAIixk7pea7/GM62
         BJAdYiNk3WRx6oKFPwRwZcTJfWtTtOy9/F2Qqe7jQIdZWgwJy6XkCRtF6MJl6Osijilk
         eQ6Q==
X-Gm-Message-State: AO0yUKVSIZn6PjJa8z7V5ciryjWD3kC9D08qSgjCuT705UmZ1DZcFx+X
        FPBeL/aS3EjDuUG5SpSqowuFyNSkGEqlpRrRzqU=
X-Google-Smtp-Source: AK7set/VqXWuGh6fjJqetYy141NHQlg3So3qENZmsTRMdmXY11WvygESIEEHqPYhEE1jCl2I/wp7VeluD0rsYBq7+Cs=
X-Received: by 2002:a05:6808:646:b0:384:8b1:215c with SMTP id
 z6-20020a056808064600b0038408b1215cmr8586924oih.0.1678514138203; Fri, 10 Mar
 2023 21:55:38 -0800 (PST)
MIME-Version: 1.0
Sender: mrsnicolemarois10@gmail.com
Received: by 2002:a05:6358:9ac1:b0:104:2ec0:e81e with HTTP; Fri, 10 Mar 2023
 21:55:37 -0800 (PST)
From:   AVA SMITH <avasmith1181@gmail.com>
Date:   Sat, 11 Mar 2023 05:55:37 +0000
X-Google-Sender-Auth: jBAYIsPh2o9DGqYqepGt925jYA4
Message-ID: <CAPsswJKgifprbsb2n7j2ctBywdLrAUGqqfhSKc3dfQk9g2kbug@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,
My name is Dr Ava Smith,a medical doctor from United States.I have
Dual citizenship which is English and French.I will share more details
about me as soon as i get a response from you.

Thanks
Ava
