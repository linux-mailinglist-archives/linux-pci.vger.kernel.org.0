Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE58590FCA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 12:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiHLKzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 06:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbiHLKzr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 06:55:47 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4719E2C9
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 03:55:45 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 73so501779pgb.9
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=447DttLGWlnXVhl3+i4qWwJxEj6tFprhGwRHCuyrWEY=;
        b=CJ8cmabUBS6s6xxd/K2d4ioKxSyRIqE+ZbMGdtOsB0xEii8PW96QxCDErfQIjC5BLN
         N2ucmgiycJJWzTi4cqrjfE9/Qd9qFAIMAw3S3lJYynV7FOantBCVlh8p1SpJp0OmBkJd
         zJ1W862js8LoAcODPIYF/9lavQGzrv9SxLLzKYwZYs+aFDugs4i1SnnikoRnH73/HBzk
         m18p9qWtHEY7DEvtYfAV2/hTbPa+PdePCQgit6nPZjTo7qoxPOQVMH1Q9ud8T5lQAHsP
         cKX6gM3XXgZAfM0H0ll1XdJ5ldBa3MmWx9WKcy61QJhphhLbPc4wMweOQcNzCq3zEyrE
         y24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=447DttLGWlnXVhl3+i4qWwJxEj6tFprhGwRHCuyrWEY=;
        b=nwxtSNpUm4GT7JGIJ8gYXiJyVX/q5u9T4OH+bDAIJTPS7Rbdv499A/oFlz57aiS6D0
         +FTfOjYF5APbtxMiN85K0/hEaokW1q9d5NhAwQ/bRH0aAAYs6S0pc/1IWIndGOlmCUWs
         6Kj+xXAbiGc8UjdK5W02Yzn4ZiECtuRzEjzFjgg7LzBVbZe99NNF41QuVD3lNGoQ7Y9K
         xchwgmyfLDVtiRSpf6jOn8AEkqUUhYZfwcui1CV98PpjhC20CUfdV26MgSa+Q33E5ZdT
         5j1MpBQtuiHGC5snBgS3SN1UDxZvtCdgm+8fk+87FGw6lF+Tigqayp15I4pmw0L/unni
         Ri5g==
X-Gm-Message-State: ACgBeo1X9ey41enaRocXy4RZWrxZQ4Sm6P5O5UVt/7/bg9tSF4jvi/oX
        Wl4KkJHZMuqqfw+WO52v3s0MKV/Or73RfWBFois=
X-Google-Smtp-Source: AA6agR5zQzBmW33GmQFIhAp2AFpk7CL7LTn9PCx8JAiUD3jKsaMXzwesI8XRy+JYh8XJgI9UhTgK6vqxdcdpvvJuJ30=
X-Received: by 2002:a65:688f:0:b0:41d:e38a:e8c4 with SMTP id
 e15-20020a65688f000000b0041de38ae8c4mr2677864pgt.437.1660301744807; Fri, 12
 Aug 2022 03:55:44 -0700 (PDT)
MIME-Version: 1.0
Sender: bazarkowanigeria@gmail.com
Received: by 2002:a17:90a:9f91:0:0:0:0 with HTTP; Fri, 12 Aug 2022 03:55:44
 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher01@gmail.com>
Date:   Fri, 12 Aug 2022 03:55:44 -0700
X-Google-Sender-Auth: 9ez0BQ54ybr4-2FSOghKq3nW-Ek
Message-ID: <CAPgaJa30zdehdauxJA=VaWKLgjKBywWenmnn-VngZ4tZAfQP_Q@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Best Regard

Mrs. Margaret
