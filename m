Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB1056BD68
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbiGHPy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiGHPy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 11:54:26 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FED70E5F
        for <linux-pci@vger.kernel.org>; Fri,  8 Jul 2022 08:54:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id be10so27469920oib.7
        for <linux-pci@vger.kernel.org>; Fri, 08 Jul 2022 08:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ecd1Q2yPx0A7W7K7jCuZP1F8wCmAYdVKX1aCc8pJ7gM=;
        b=he6uprkL4L/rxRLmw7Eq+/hYT0O5Xvo5QvZNdCN37MzUqtNbI6DIH58zGH/PbupIOf
         zuLGVhZLXbeQJkP6p4WyQcqFK2EUWTMs8B+mmzSKTyTyLV6ibHwg+Ebc488FCdhdzH9Q
         1/Lt49FPOxD45JfZrACO2Xui3rH+fy7IcTyXJC/AY868KP1PKp+BQeXrVMm3YkzoEbLC
         AfDfAJs70lZLhq6Nxfn/YXRMKrnqhWjAtd0NjsxdS5sBITHw4Z/CYcAjsxvJMXjKSWt+
         ljdcyrDhmCAx2oFAyi0us5kTKabH+T48IlRuy7ksF8q47p2rqcxo0vr35hjHzd18eJzD
         4FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ecd1Q2yPx0A7W7K7jCuZP1F8wCmAYdVKX1aCc8pJ7gM=;
        b=m7CqJLDTF4FMzZvgQtPNnHQ7qpqy5DEkP7NAzzHlRrgp0HcqEX+yYChB6EI2nf9vjV
         X0QklfNBEPVq5slk/bgkrqHYHHvy8J+E3tcYVuvy6emi1tAp6LEC5QN0snKbnYfmaA20
         WbzMp2SVevdRmI5BLdV1v1cHv8ka5aVP0bUve6uzt7txpue64mdxBcXEF3s1rn05WQ69
         7iPsH747oKn1tUSyGE0tSVmRNNf5IDt5zbt/r2EZYbjI2igy57ipMzWnjKyG3Yadyibi
         tMA+zkcJO2ODKTHRt3U2rK7XupvX/xSZjYnlvim9ZKG2/NGXBVDtaw3HYRSaui/HGYSh
         31JQ==
X-Gm-Message-State: AJIora+MGRakINEnnSmZYHaQ9tJTQuV3OhF6K5nXgXQTGiEOW93j/x/B
        wJYXkCitSZssxvVwryxXbBtndUkCds2L3U5M9dg=
X-Google-Smtp-Source: AGRyM1vfP/+1dU50Cn6+dH/I0Aq+xuq/ReMZ7oYDUrrDRatqdeNWZe+5zTJkijD7gk2E1pimEUOXnYfGExJKhCMSmVY=
X-Received: by 2002:a05:6808:1786:b0:335:7355:7332 with SMTP id
 bg6-20020a056808178600b0033573557332mr265104oib.167.1657295663412; Fri, 08
 Jul 2022 08:54:23 -0700 (PDT)
MIME-Version: 1.0
Sender: mr.azzizsalim@gmail.com
Received: by 2002:ac9:7f8c:0:0:0:0:0 with HTTP; Fri, 8 Jul 2022 08:54:23 -0700 (PDT)
From:   "Mr. Jimmy Moore" <jimmymoore265@gmail.com>
Date:   Fri, 8 Jul 2022 18:54:23 +0300
X-Google-Sender-Auth: HOp36gZ2rFW3AJRPfoRrNm-0Dro
Message-ID: <CADCzDA0n8gt9R8cahi93WzVVnafc3k8_tGuvA=3=FDrjiveF9w@mail.gmail.com>
Subject: UNITED NATIONS COVID-19 COMPENSATION FUNDS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,LOTTO_DEPT,MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:243 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5925]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mr.azzizsalim[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  2.0 LOTTO_DEPT Claims Department
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UNITED NATIONS COVID-19 OVERDUE COMPENSATION UNIT.
REFERENCE PAYMENT CODE: 8525595
BAILOUT AMOUNT:$3.5 MILLION USD
ADDRESS: NEW YORK, NY 10017, UNITED STATES

Dear award recipient, Covid-19 Compensation funds.

You are receiving this correspondence because we have finally reached
a consensus with the UN, IRS, and IMF that your total fund worth $3.5
Million Dollars of Covid-19 Compensation payment shall be delivered to
your nominated mode of receipt, and you are expected to pay the sum of
$12,000 for levies owed to authorities after receiving your funds.

You have a grace period of 2 weeks to pay the $12,000 levy after you
have received your Covid-19 Compensation total sum of $3.5 Million. We
shall proceed with the payment of your bailout grant only if you agree
to the terms and conditions stated.

Contact Dr. Mustafa Ali for more information by email at: (
mustafaliali180@gmail.com ) Your consent in this regard would be
highly appreciated.

Regards,
Mr. Jimmy Moore.
Undersecretary-General United Nations
Office of Internal Oversight-UNIOS.
