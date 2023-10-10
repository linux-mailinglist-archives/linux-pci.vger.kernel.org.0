Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4837C4379
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 00:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjJJWIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 18:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjJJWIa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 18:08:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E4094
        for <linux-pci@vger.kernel.org>; Tue, 10 Oct 2023 15:08:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50329046cc1so2176185e87.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Oct 2023 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696975703; x=1697580503; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MKNsm+wLhzNuGe8UrUTSn6sOAcZ7LgU/g+7UuiHWOM=;
        b=XId5GWBWslBl71EpmkAEFpYFaIZNNXVFOvJS2BiR4xUbfAJ9UkLre5kJV0SoOAkIPU
         4UjmiWJhvIv5EcBWLfzXb5EcjwdTIbkGJghNgaLxoGoevX/1mihCUPf1vA9/QRSh/U1w
         N/qbOkKn5UlQRQrDGOANKsEWXA5w09rGYYzuNxI3N7COe+nBk6qKXmAJy1Wq6Y0axYfS
         SZSz2uYThNiFZFDyhUGEQT+9t4tEn7Xcp1L5eGBcgjmTVIqKXol76EovcKwZJcSdwMOm
         IfT83KWET/S07PgIgwv+foZoSXjQK6enL5xhyqv52mvgj399LG/M99wZ3EJpPFNdywOD
         Qevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696975703; x=1697580503;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MKNsm+wLhzNuGe8UrUTSn6sOAcZ7LgU/g+7UuiHWOM=;
        b=Ym6scfr8QIntXS2KP2rNtD+BJaya8JrcpQpDy80Esh3+7/9n1bS5YFw5RS3QKO5pL0
         RHtiXarE3Gn2P+g+shIhRmqIKzPZ6dz6tgjvo0oRzrHFLvhcLM/Et+9nm1J+s8fyHwfy
         YedoocqYtfpGiM3St+/iZ9sWPFPOeDwg78XogMocliK0Y3tlp6A0Vipos5zPNgaGg/v5
         TYPPP5eG0Tkrmzkgw7HY3cHdkjOLhCUXKu44ZtJ5pgskhAv9tIalu2/991/6HTopUDfv
         aJZRtfUM26Kla+goc19ZiAD8qGxLdqWYQgwlcI+SHGqz6xFWH/grqD4rseblEVaMwkPd
         icyw==
X-Gm-Message-State: AOJu0YxuiZblSxm7KyjgrMpbXSbaG073zPVagYPihT72LULGAZNzVa97
        jj+UYLE0/0mVtQcCH8UUdHAVGNQQN4k0euzgw+c=
X-Google-Smtp-Source: AGHT+IHf9wfr9FztnIIV4gOAalf8QfJKpwLXAbHJBUx/WUN2LZqRPhsmrHuvOoHsLWes4PCssWlBDt3uV/HSHeqMIX8=
X-Received: by 2002:a19:7417:0:b0:4fb:9477:f713 with SMTP id
 v23-20020a197417000000b004fb9477f713mr15868083lfe.6.1696975703049; Tue, 10
 Oct 2023 15:08:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6022:a10d:b0:48:2312:e0df with HTTP; Tue, 10 Oct 2023
 15:08:21 -0700 (PDT)
Reply-To: tchalimbenson@gmail.com
From:   Benson Tchalim <milleym513@gmail.com>
Date:   Tue, 10 Oct 2023 22:08:21 +0000
Message-ID: <CAKgnd7jNOoEYpdn=BJSqWjDbZTaVDzmoJKd2JDhd4TnyREZ_Qg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
I wrote you a message since then no response what happen?
