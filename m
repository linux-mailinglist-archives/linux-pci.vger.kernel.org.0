Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEDA550672
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 20:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiFRSKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jun 2022 14:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiFRSKc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Jun 2022 14:10:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CD010FFC
        for <linux-pci@vger.kernel.org>; Sat, 18 Jun 2022 11:10:31 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k22so3010109wrd.6
        for <linux-pci@vger.kernel.org>; Sat, 18 Jun 2022 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=stMUqBGDU6EWwG218v457jIAcS1AbkkNmMvvKXiLshc=;
        b=AvV3mwFOKIyl7S4MWEhwDgKjJ6hP+2SVk0ie6YOY96rhlyZAd3ZfueHdqwHCshtQKe
         /vbfC8aFuXDb8wXsTn4a59dQo97RdDE437uHfoUU7iXeK1QL9Xpi5dSONYVwfs9h2WCn
         Qa4Y5Bn8muxHY/bc+D5JR0UvcyzFqfQTbvKwjKlJNN56m8d+5f+Qxk4abxYiVtI5Dd9N
         9tlrG8KkDHWkv14ILi3AzEXTtXCWbX22TQDihKlTxsj2wt8Ey2spjkz91D/F1PxxPmMr
         832Osru61DAOpQwXRQ+0crhBGdF+xWhOdHr9sr3LuoeqbL649szdJRIAojJl4+Kz5eSa
         ujjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=stMUqBGDU6EWwG218v457jIAcS1AbkkNmMvvKXiLshc=;
        b=BKalQbrAIeuuZM4oNmiZGC1MLYitoCS68fQIzsSbPDYNEo0xPOZ5xHoOTqWjYoSwut
         3T61swXd0m6CHy12bwflVNGuZ4GPlfUjXiR1etIIODsc6mB7dZQaYTdryzXyT9K+/KWH
         r/t+cYCeGwG3r6MwqnE/jEd/xDiOr5E3KEfFK/S4d47lCujJm6V5PbpYqdabdMGtqlTs
         K+20NjOt6IcDmmd/IvE6vMTdOEiKZGo7peojoRZqhYOmvqzImi6wOOlBW4r9KQ/JXoal
         fVFMS+OJMWfeqtiLsaE3z42alvvGueumdTcfhxi3vKuXkqgdMy6oj2S99yNST9x82/Kv
         aaSg==
X-Gm-Message-State: AJIora9sEdKEpWCXwjr/vhtNhW+Hnyui/8uWBAOPUU3NOBI+nslyc2rL
        VmDdygaojcnnnGe7KhXIEnsVK2maPo2YP+Tdf9k=
X-Google-Smtp-Source: AGRyM1tOBLaoQOHIzkG5kHvfcn1Zqz/zJGtb7va6YtC/XF8qdRWnRWpWl7JHQBra9j+vlsYz3x8oQam4kKU+ivPoj60=
X-Received: by 2002:adf:e252:0:b0:21b:827e:4c63 with SMTP id
 bl18-20020adfe252000000b0021b827e4c63mr6215752wrb.307.1655575829526; Sat, 18
 Jun 2022 11:10:29 -0700 (PDT)
MIME-Version: 1.0
Sender: shaoibwin1@gmail.com
Received: by 2002:a05:6000:1f11:0:0:0:0 with HTTP; Sat, 18 Jun 2022 11:10:29
 -0700 (PDT)
From:   "Mr. Stephen Mensah" <stephmensah01@gmail.com>
Date:   Sat, 18 Jun 2022 11:10:29 -0700
X-Google-Sender-Auth: 0wvBDvxs_RpFHURWcg-z0yS6LVQ
Message-ID: <CAMLkz8cfQdUvzjjArnqktFgNahcVyhC5qVM3R6Uqq57Znm5h6w@mail.gmail.com>
Subject: MY REGARDS TO YOU
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
My name is Mr. Stephen Mensah, I am a politician from Ghana and also a
formal manager in a financial institution as a Senior Economic Adviser
to Government Ghana. I got your contact from the Ministry of Foreign
Affairs and Ministry of International Trade and Industry, I am
searching for a reliable and experienced business expert that can
guide me in setting up a lucrative business investment, so I decided
to look for a tourism country or secure country for this investment
project. I have U$12.5 Million Dollars and I need your assistance and
guidance to invest the money in your country.

If you are capable and willing to assist me in collaborating with me
to invest the fund in your country. Do not hesitate in writing to me
immediately.


Best Regards,
Mr. Stephen Mensah
