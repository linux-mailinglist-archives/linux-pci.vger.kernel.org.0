Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DF06EED02
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 06:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbjDZEmx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 00:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239399AbjDZEmu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 00:42:50 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CEE26BD
        for <linux-pci@vger.kernel.org>; Tue, 25 Apr 2023 21:42:48 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id 006d021491bc7-5476a2780a0so2806973eaf.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Apr 2023 21:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682484168; x=1685076168;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=ahJMIWTh5hWsknwjxsHnHQo9L9VjzYcn1k/0nU23PU9uEZU8NalnBK3f9aVgzZCo5r
         +p006FX/ZwqMvKSjA6VHEj3uIqzR993g9P1CrFK9Fivzgwmca8kxjeyWkyvWkLEi20By
         rct6ZAMuikhMKj/3DXx5AKfXigvurLbq4PilgTtzLaX/aYV2jyLFb01f0/lE77UE8BOc
         ML+1/nS9zkVDTQXcJNJoyM+er+SvJwqMhIgEhQBdEjVaUbzrCEWRuqiCz7c6sMP2L2E+
         MlXEZJFcfRL02s5L4RO1N8I6SOXxlWfGIeqLuoo5V3O7DfHscz5K73m9EKR1oRzUmK1z
         5l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682484168; x=1685076168;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=S7B1T7pVNMmwQYeg2VE93N/E8BF+vCvXdUJ3SLGmFMhlgnlcg6ZYFJrD0RtVV7J+o5
         aiGdQgP1S31l5StHZk2cfEzEMP8xt2MNUZzaZmAE3Z0PzwrilnOgDjSYfvzdLpPqzJjE
         d96wEqBQLQAQMtngxabZAM75rRKQ/aVyTWmKr+qnnRxTt++6wmIDuMnAlnZGNjzK1rNn
         qLcd8ZlEH9EGm473u1+KPNAjlrLr3qW/ZC2sxEWMzcq634azLowg9lzYNFr9D5rfKo5e
         vPNW/Vmy5MGwrzg4CTGQAqgGslF3pgg/aSUoQjNGELKnSI5nkdNr3FaQ8RPpQn7asjNF
         b+Ew==
X-Gm-Message-State: AAQBX9dqF21jLYx5pS94+Vu7vY7CKeG4KD4F3GhQ4jTANsML/nqQMpSP
        61iDl1U30de1DKMfsBztdwQvR12vJlIpYjBkX3Y=
X-Google-Smtp-Source: AKy350bOLIyI+w9KrBjo8wnTDAYvlhBLAGs13pccFIMH9r8rI9git9fbIly8hLQTWzX3A/fyOGsGfQkHlyrIgnqmVnc=
X-Received: by 2002:a05:6808:1885:b0:38b:6c2c:3168 with SMTP id
 bi5-20020a056808188500b0038b6c2c3168mr10879839oib.35.1682484167861; Tue, 25
 Apr 2023 21:42:47 -0700 (PDT)
MIME-Version: 1.0
Sender: mrs.nicolemarois555@gmail.com
Received: by 2002:a05:6850:190d:b0:472:4a8e:9aa6 with HTTP; Tue, 25 Apr 2023
 21:42:47 -0700 (PDT)
From:   AVA SMITH <avasmith1181@gmail.com>
Date:   Wed, 26 Apr 2023 04:42:47 +0000
X-Google-Sender-Auth: oLN8TkQTeeK3qe33xEXBWukGFxo
Message-ID: <CANiD9SJaRynGGmJb2Z8thdK8fg7qLtPr09Js5yoCTSpw2g-c1Q@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
