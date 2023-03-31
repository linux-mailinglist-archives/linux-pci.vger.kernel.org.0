Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4976D28A1
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 21:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCaT01 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 15:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCaT00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 15:26:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BF322E90
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 12:26:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g19so17146336lfr.9
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680290783;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TnELEkkU0k3B8aha6G73Plasv6HbiFbmUBX3+pFRiNs=;
        b=aDmPP4JX1GsgeLzRAKLkx3ef0Uwab/CGQZRJq2U0mxlueg2en4QC90W58wbi4ndW6c
         iih67eVat6ZFwJtoRenIA5IBadVWvBcKAdTQWHzsTl+Jwumx4/MCNQRt7qtXYw7KtMhw
         Yz/2f147Xo6wG2N9JsCoc4V2hq0+ipQnAOeEY8MSVpCsEkwKVEKdGgal33eTzdWlm6c2
         1RVFAy4hnX6wssy1RUxWownAijDOdGfUBon+zhywGpNhiTMZpvokA3N5oISnxEaPPxws
         R7meH93kuNezlvrC4/bqTznRB89zhHt4gI7vP7FeT1SdVAYwSDG/uCYQDFVo8PFHzkOe
         caNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680290783;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TnELEkkU0k3B8aha6G73Plasv6HbiFbmUBX3+pFRiNs=;
        b=jVBtYZ1k0uLx4IlTeOBbEkHRPkkh6jTq1Sm1wmpudm4Dx0ZQPCBwQWUtEslgbglfTm
         oZLDj1NuT7qB31/FXB2RJ45aO9POPdbCPW/4KaJFKn3MnYM6q824tjqdDdILiNSkBKbG
         m2gELrwteYI3ZUzYrRq/3q8KVQA3pW2XMkk/up9lWL9kHZx3MQE56HYKTZSbkSd8W8gn
         ZZJ8Wxw5wsneC6foMH3CvF7IhMAiwOUoNUi3qJhK6WSETAViptRers+fMwOT2K4k7sPT
         uf5PwP9gLQg7kE7oE7vb9xSFax/+hO3B5J8AIxaqS1/MZIuc5oAfervzuLE89CzhQ99c
         qBNg==
X-Gm-Message-State: AAQBX9fnCACaBZL0uTqYrh68j6owvzxW8sZ26T+qo8bPQvNLtXPqKYm3
        +wOQWJ6D2euTgxRLwKfv+wEfnv1ZnNwfiRpejtY=
X-Google-Smtp-Source: AKy350aB5NxI3WzYlngiAYplomZrjaX09ybXFTuJtBBicX4ye2fY7FntOuHHiS1RFy77tj3bdDv6wuDDlPfFOF6PEA0=
X-Received: by 2002:ac2:50c3:0:b0:4d5:ca32:6aea with SMTP id
 h3-20020ac250c3000000b004d5ca326aeamr8468845lfm.10.1680290783109; Fri, 31 Mar
 2023 12:26:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9a:714c:0:b0:24f:3288:af6b with HTTP; Fri, 31 Mar 2023
 12:26:22 -0700 (PDT)
Reply-To: lisajon1237@gmail.com
From:   Lisa Johnson <02mshelby@gmail.com>
Date:   Fri, 31 Mar 2023 20:26:22 +0100
Message-ID: <CAC0cRmO6w13Y2ZKSoe73yJmUxjTYn79WkCY0xNzj279TWuzCOQ@mail.gmail.com>
Subject: Kindly Respond
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello my dear,

My name is Lisa Johnson. I sent you a letter a month ago, did you
receive my previous message ? I have a
very important project I would love to discuss with you, Please get
back to me as soon as you read my message, So that I can give you the
full details of the project. I have
prayed about this, and I am doing it with all my heart.

I await your response.

Best regards,
Lisa
---------------------------------------------------------------------------=
-------------------------------------------
Hei rakkaani,

Nimeni on Lisa Johnson. L=C3=A4hetin sinulle kirjeen kuukausi sitten,
saitko edellisen viestini? minulla on
eritt=C3=A4in t=C3=A4rke=C3=A4 projekti, josta haluaisin keskustella kanssa=
si, ota
takaisin minulle heti, kun olet lukenut viestini, jotta voin antaa
sinulle t=C3=A4ydelliset tiedot projektista. minulla on
rukoilin t=C3=A4st=C3=A4, ja teen sen koko syd=C3=A4mest=C3=A4ni.

Odotan vastaustasi.

Parhain terveisin,
Lisa
