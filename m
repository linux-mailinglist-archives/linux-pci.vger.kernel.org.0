Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6F153D235
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 21:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349035AbiFCTIu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbiFCTIt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 15:08:49 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9B73917A
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 12:08:46 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id c17-20020a4ac311000000b0040ea8bf80f2so1620939ooq.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Jun 2022 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=uQm69jIgbOTyn1ClmnjZvF1mQyllP9AbcSxz7NY1e74=;
        b=peMTcS2J0bkhcQfLpXY5HI+ynpJKNL1j7TT3n6xhnGINfudOzs/Wy5e9dOkvukoucU
         QNydhfLVmiD4XxjbixY4MdYa0ULFfRmO+C8wExU9wYO734rkxFtFvLbBSYiVES+YUsWx
         kg5nWq72UAX3I5at0ImMcE8uK3uCDT6FwR74Xfp+R86JbeLJqZWmVf1xdMp6z7SnM/yw
         tP/12eTd0FRWERzniS9Ywa+QbfrWGQCDNrQkWB3LdqvrmccIu2JJWl7q1B8AAnYB2qf4
         z+w90BsW60aRRW+4F2qwj8D0FsuoSPnNqveyuDudklGNo/81PwLtg+pvXRLQCTNkByGE
         WgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=uQm69jIgbOTyn1ClmnjZvF1mQyllP9AbcSxz7NY1e74=;
        b=8Ekw+iK+B9Rg1TZLwio3cs/0D69sZvwgPZQPjomuLbnPUh2JdqdlEbqU4InKmWjjK5
         U4nZgDw2wjTB5YSPKzRiHJqBBaiR8P1ndC5jXPb9zgjGA38w/URdy8cq3tUR1FIFKAs4
         RKEhWJ4uaeVSh6V7HL2V6soiOse+tyrOxudhX4BZ6iGgTPheSEjOyBHhp2Dnm9uhCm6L
         j9ys+ft+ccjeGFAsWcBboz4cEkPHcB7twxcjwSBs01H/B77CBfoV8109q+8PgpWjy/SF
         dwYWVgNuADexy+hcmBpn2/nxHjY7IPl3/ZtJJMU5678Bs0hkZF8ohEplzF1ccjPFOCwS
         hTgA==
X-Gm-Message-State: AOAM5335a9l/KxeN/5Bn4jNEbPuLfuME93DPTnkVKg8zmSAChytxuSlN
        tGpf4bknPRxsv/RdWxaTFyNfvtGgltMhCoT+59I=
X-Google-Smtp-Source: ABdhPJzPqr9ZJ75Di+tbMESnTfkIbH6PQ3O3mesgCBPuOrGJp0v+tITSgNkU3WRdfpwQIjwRVbypZGhoNlkRJn+M2B4=
X-Received: by 2002:a4a:eac7:0:b0:40e:5c32:42f with SMTP id
 s7-20020a4aeac7000000b0040e5c32042fmr4794281ooh.52.1654283326102; Fri, 03 Jun
 2022 12:08:46 -0700 (PDT)
MIME-Version: 1.0
Sender: sujitnoo030@gmail.com
Received: by 2002:a05:6358:c21:b0:a3:41b9:b883 with HTTP; Fri, 3 Jun 2022
 12:08:45 -0700 (PDT)
From:   "Mr. Jimmy Moore" <jimmymoore265@gmail.com>
Date:   Fri, 3 Jun 2022 20:08:45 +0100
X-Google-Sender-Auth: HJSPW36J7I-RtMMQntEJbYelM4Y
Message-ID: <CAAJKTSX1Vg6CQtPch_nYOb3yfkEh7HdqQvGydTEaGrrF2S6TTw@mail.gmail.com>
Subject: UNITED NATIONS COVID-19 COMPENSATION FUND.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,MILLION_USD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UNITED NATIONS COVID-19 OVERDUE COMPENSATION UNIT.
REFERENCE PAYMENT CODE: 8525595
BAILOUT AMOUNT:$3.5 MILLION USD
ADDRESS: NEW YORK, NY 10017, UNITED STATES

Dear award recipient, Covid-19 Compensation Funds.

You are receiving this correspondence because we have finally reached
a consensus with the UN, IRS, and IMF that your total fund worth $3.5
Million Dollars of Covid-19 Compensation payment shall be delivered to
your nominated mode of receipt, and you are expected to pay the sum of
$12,000 for levies owed to authorities after receiving your funds.

You have a grace period of 2 weeks to pay the $12,000 levy after you
have received your Covid-19 Compensation total sum of $3.5 Million. We
shall proceed with the payment of your bailout grant only if you agree
to the terms and conditions stated.

Contact Dr. Mustafa Ali, for more information by email at:(
mustafaliali180@gmail.com ) Your consent in this regard would be
highly appreciated.

Best Regards,
Mr. Jimmy Moore.
Undersecretary-General United Nations
Office of Internal Oversight-UNIOS
UN making the world a better place
