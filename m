Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B302426549
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 09:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhJHHgf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 03:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhJHHgf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Oct 2021 03:36:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D59DC061755
        for <linux-pci@vger.kernel.org>; Fri,  8 Oct 2021 00:34:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m22so26897020wrb.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Oct 2021 00:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=S5sdFu0RQlZFvupo/qwNdlJ2GO8zZANN1PS6veJLDy8=;
        b=ckmLyNMyI/rHvGb2WsCbFSeZsREB39PkK6VARCp99DYw5P8MagOJgMRGzW6Ig/qs4T
         ioBv0XFy7gE/yjNIHjj454q+PdwUIwqhXphn5eOHk/uZ3rXZGPgY2kEIJhocagZY+fl6
         FhDdDwLX9xF/FZ1hjnPd5/zy0bDb9hKqT2WPrDkpErxxsOHzXoY3Q//FzpUR6V2IO+o2
         HDQWdBOb3KFvxQF8Vsm26HLuaZtNwFR33STgJwxhPpZegAJAb74Pm0dkN9NJtoUa5wsY
         SWea3MZJlkItNmnFMz0/CQGLSyJKvEK+ARgTiPkVEn1ZPCmkAtsBF7qlkcS5ZF4UnwTX
         wn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=S5sdFu0RQlZFvupo/qwNdlJ2GO8zZANN1PS6veJLDy8=;
        b=BI/tJuZulaqgy1y1NAEVy7ZCeNxUS0P6+uzyNdTprVoa0eVwObt/w8cvTcsy3YWF/K
         mEpZtY8Py2PYR2CNaDncZCyFsDLFgqLJ2f6KfnMbsZUnkE1F8g4bjK+VM8sgRuQHp7LY
         1WM0nBrWrvAVwSzgSrDRrQ06ZEwthopotpLP8Dh/yPkcOPBK8zoOUJpCs1PtTGXdbLa1
         1pe3cM5ZU6oYEvIr3N62qXAeYMo/OG1c5zkUT485r2oEQPduh6YOwDngHe1PjugFa2YC
         UjOSauB/xxLTllr2RF2la3q8TTbTNtkOh53cnUzMaVcdcdyA5j9gD8fUTWuVDv92Gq/3
         WHeA==
X-Gm-Message-State: AOAM533GIDxZoZD0MxYArPNkJsv9QJPasv3RhNuNEn/XFc6viuUMqUB2
        +3ciJlyWFvoItp6CviIZBGCcmIYfIW+2DzoINBI=
X-Google-Smtp-Source: ABdhPJwJz/lcs7zr0sTPs/NEEO+galFaH3TtaQRYibEZoXhxqfLz2eUN+dX+jh1mdW1uj3K0PFUg3+9ZmyCUngfIhwM=
X-Received: by 2002:a05:6000:2af:: with SMTP id l15mr2019312wry.129.1633678478824;
 Fri, 08 Oct 2021 00:34:38 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kl621816@gmail.com
Sender: mrs.anuradha1@gmail.com
Received: by 2002:a05:6000:1565:0:0:0:0 with HTTP; Fri, 8 Oct 2021 00:34:37
 -0700 (PDT)
From:   "Mr Ali Musa." <hippolytepilabre@gmail.com>
Date:   Fri, 8 Oct 2021 00:34:37 -0700
X-Google-Sender-Auth: GVXFEQlEoIcU6ZNTIel3kgCsk4Q
Message-ID: <CAAmnbBnifVCz85F0-grggkXGMxSnaDQ_wmML4hY03GYLwU5=uQ@mail.gmail.com>
Subject: INTRODUCTION:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Friend,

 How are you today, Please accept my sincere apologies if my email
does not meet your business or personal ethics, I really like to have
a good relationship with you, and I have a special reason why I
decided to contact you because of the urgency of my situation here.I
came across your e-mail contact prior to a private search while in
need of your assistance.

INTRODUCTION: Am Mr Ali Musa a Banker and in one way or the other was
hoping you will cooperate with me as a partner in a project of
transferring an abandoned fund of a late customer of the bank worth of

$18,000,000 (Eighteen Million Dollars US).

This will be disbursed or shared between the both of us in these
percentages, 55% for me and 45% for you. Contact me immediately if
that is alright with you so that we can enter in agreement before we
start

processing for the transfer of the funds. If you are satisfied with
this proposal, please provide the below details for the Mutual
Confidentiality Agreement:

1. Full Name and Address

2. Occupation and Country of Origin

3. Telephone Number

4. A scan copy of your identification

I wait for your response so that we can commence on this transaction
as soon as possible.

Regards,
Mr Ali Musa.
