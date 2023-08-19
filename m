Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6955B7816C6
	for <lists+linux-pci@lfdr.de>; Sat, 19 Aug 2023 04:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244190AbjHSCmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 22:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244254AbjHSCmi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 22:42:38 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499714223
        for <linux-pci@vger.kernel.org>; Fri, 18 Aug 2023 19:42:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ff975a9318so2237073e87.2
        for <linux-pci@vger.kernel.org>; Fri, 18 Aug 2023 19:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692412955; x=1693017755;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7acdhpg3sia0HTiOORSZxWs0IKp/G5AcbjrZmqozbxI=;
        b=oX5r2xZZwdR6QtRQyYMTGWMaU2GzGyc2/EarYg0cXvNqHQK7NodcNNjBOTzjxs8xA/
         ZivxL3zxvnlV/W0JdISCX066p1FcF96wPBwoZCFNfRW3k3kxUNio+eX+JEwzDv22NOLS
         zO7QIz9FvTcQppMCEw9mVN6qZiUafG6Iy6/3GPej80tX1OqSiaUB9GJex9cYt4fH5z3Y
         At74OIBxgCiTCpIQSRNUfpuWt4stkwjwny0XEVnKmOYuyXhmBZx8z9eJyqZRTlBe/PMa
         PIm1WPMjglg4pm6irxS62rLOkoRCy8s+YopcXygUpkUvruz/yNAf925ir8UDgjIz9lM+
         OxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692412955; x=1693017755;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7acdhpg3sia0HTiOORSZxWs0IKp/G5AcbjrZmqozbxI=;
        b=j7Z3iyxRxtyLlwLBK+ecgjp+h2Itb00snal97iuqcihpmiWyqIju2Tu5Ptav/7KlOJ
         jByw9Te8htUWhH6YuvmJeJGpJI4Jhu/ndMLEjbg2z0Ves2XFfINfdmpErT7lmhHJogUx
         ErlrpOTZvKlUb8O3621tktsqmR2C6e8cKRKgCZ7DkdKsXVbq4BC5Qzug7oQpyeI415uF
         5m3gldymXdRdkQydRq4WyQMtjAWzpSg2jfTZWG2ju3myH/UulGUf/AWR7KgM2giilL5N
         MOJcFLsDrnRfKFAV5bZutfXeFZXr2cNnsSy82EnxA4xGpJO9tDS++SVUwXReztWgGfq/
         sl7Q==
X-Gm-Message-State: AOJu0YwwGeHtq6rBd/dBnCuSSTgkhqZUeTsBU3AttBR2L7NhwdSezrha
        uVPUWOJm+JXwXnYh6go6q98N/5Ok0loS46x+2/hlKeXQ/c5Usw==
X-Google-Smtp-Source: AGHT+IGQrivof/SO6vpAvOav+P2boAKR0u2M2QPpS/IedinGEZUaOfIs17LgGmDNa/EEQwJJUDfm0IMFWXs4Ad+cRe0=
X-Received: by 2002:a05:6512:1088:b0:4fb:89b3:3373 with SMTP id
 j8-20020a056512108800b004fb89b33373mr728779lfg.43.1692412955366; Fri, 18 Aug
 2023 19:42:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:1482:b0:233:69b6:e3e1 with HTTP; Fri, 18 Aug 2023
 19:42:34 -0700 (PDT)
Reply-To: mohammedabuhamman066@gmail.com
From:   Barrister Mohammed Abu Hamman <btimothykimberly@gmail.com>
Date:   Fri, 18 Aug 2023 21:42:34 -0500
Message-ID: <CAMJXB=txg5aVoaeBa3+QcWukZR_3CZW2e+N6C+6qf9xK27dPDQ@mail.gmail.com>
Subject: Thank you for your kind attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Good day.
I emailed you a week ago, but I=E2=80=99m not sure if you received it. Plea=
se
confirm if you receive it or not so I can be sure. Thank you.
Yours Sincerely,
Mr.Mohammed
