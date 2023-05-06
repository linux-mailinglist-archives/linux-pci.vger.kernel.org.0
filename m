Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC96F92AD
	for <lists+linux-pci@lfdr.de>; Sat,  6 May 2023 17:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjEFPZK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 May 2023 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjEFPZJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 May 2023 11:25:09 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1C17DC2
        for <linux-pci@vger.kernel.org>; Sat,  6 May 2023 08:25:08 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-38e3228d120so1260679b6e.3
        for <linux-pci@vger.kernel.org>; Sat, 06 May 2023 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683386708; x=1685978708;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IVH6bLEV7bmOSbfvMjRAiBtq+GxXoYrLh3/SPSKZzrU=;
        b=WsyjCRQxcA7tLjF1Hqxo2EsrcgUurVS2xjaXRH+0kI0kw9tODg8QiGcSNu65hzbN8e
         nsFLvwve1YrIsTpq2y6w81ZxtYFRz/hKMMcxyHrcNRunqNVtXmvEXQq6g9pZ5raA3Xog
         lvhKMxZAtRC8dlfaGY5iLf24Uyrm5lf1dpMKpZ6mR9E6qqKH6YGPAZnLkPjmRFmgh0us
         t2srnAYkonCXkOGORLfaUuYnQ4aKjweNKg0WYBiwJWgeCXcXDwRoWGlLe9pejJa1K9IS
         /bzc9c1VWaqH1DjFE3g25hSacp8v7UvKkoEL+OgwKAyjDmB7XoHuRegzA+Fbedpq77qj
         Ll5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683386708; x=1685978708;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVH6bLEV7bmOSbfvMjRAiBtq+GxXoYrLh3/SPSKZzrU=;
        b=J/QJmy7OBgQ5OL2zl3SNeI95tzLAqJg3mazcfxSpg3/GsbmRf7OMlB0ZL/7OVGrH3A
         Q4X/sHKyY5Pi/+12yU7uowYU4eLafcS6RhUaIBfJ+aWZrUYKnAgpzooGy6VXx8FEBZ6N
         BYNJGe7O4NohBJmCGdyT9D0PVi4v+ujaMCWVGKZZ7ogZkQ2hT7oa9VJlcPLp4Af2rqlI
         RxTf7zFC1oxh5g7X2rZwYQjHby52ocUhye01Pl62kmW9cerhavNCPUtwCjVb0t9Ovtwd
         2OCaV4enQM71/GIpOpEoqm7oXA0GXH91JSFGB0Hi1KcDyxlOI2KCkCCsTTxRZ0SE/eaV
         /N3w==
X-Gm-Message-State: AC+VfDzlQObZAgMy8BjKF5tgxbxhntf5w+IxRYc2PII+BILeWPUkngKU
        egvM8O1fZ0vOOklKdMXfSwvg/3DFBXQKDZ+3rhqD0ycRMCDMXA==
X-Google-Smtp-Source: ACHHUZ7FGlJ4SzOEvEdObMfsAFhbtFPGAQweCUOq8ZJTRxVyUdFE1evJeA9s5FprSKxxqev3hA3Qtxt8K3zCBAvpXQc=
X-Received: by 2002:a54:4802:0:b0:38c:3c53:9e15 with SMTP id
 j2-20020a544802000000b0038c3c539e15mr2361777oij.13.1683386707972; Sat, 06 May
 2023 08:25:07 -0700 (PDT)
MIME-Version: 1.0
From:   Yohei Kuga <sora.rg@gmail.com>
Date:   Sun, 7 May 2023 00:24:57 +0900
Message-ID: <CAMixPLfy_DV4n_GQSxCsnhw5yuwAxT+gjFByu-bakzAEMYi-2g@mail.gmail.com>
Subject: 
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

unsubscribe linux-pci
--
sora
