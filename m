Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C025BB861
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 15:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIQNMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Sep 2022 09:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQNMW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Sep 2022 09:12:22 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437C22A404
        for <linux-pci@vger.kernel.org>; Sat, 17 Sep 2022 06:12:21 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g12so17418347qts.1
        for <linux-pci@vger.kernel.org>; Sat, 17 Sep 2022 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=B/bzVap7w2nbpPLUVaGrgo7Id2TJpqaHDpbbBhcEalA=;
        b=q8FY89Iib7PuZtmtl8XTs4wLsLY9PvBiT10gAInIYRe6IyfhemSYW+MD4x5vHYB7Jm
         Wjx0FtQc7ZYqCzaas+WrGwfME8vK5ojzwmDcU55zpE6ZdUUzs3lscmJ3My4vxbl8qlpa
         LqS/dKscLara4OaH1P7avR/lAKRQhQ8JuY3WRpJw9Qyek/pNLvDyQM9y3o16vxWdXcxm
         onUi+iNNArDzP9f6OhPHLtmaJtbAzbl9YuKyjNGj/VpSeqeEUHd52aXSGlUEljQHuuxO
         IqtZT1b2x7yTctMMoBiVj8iImKjEYODOPXPiD2lynEBYqLi6uE3miBWL2sd1om5Z7MY/
         dV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=B/bzVap7w2nbpPLUVaGrgo7Id2TJpqaHDpbbBhcEalA=;
        b=ifsI8SMTMms/J1lWaEIxW2IFQDtXHZX/vMHDIWb1kfl/up3Q/RX7bdmVNPCER27/Ha
         otzzZSaBXy9errwctodbTysQJfCEO3+hKT1R6T6Poqt8ZAK+jv4BSXDrEc77c1Bs7aua
         3jH3NNCUFWYg9/Rt83NEY7vgRKthNnqCDdczZHyb3nQecbaA9Psl4FvnjubK0DO7q7Pb
         b+JCA/TwStZtflfQX/dTU0zVrO48xVqTWwu3xZ5yVwR+5Itj9XDlB2PUhczhKZEYPDRY
         ki1g3gRciQnTli5XSchXqm4i5r8CFhFzAOClwTwvbSwn/33oynVhN2iqcFpJXFNSDMg4
         ZMdg==
X-Gm-Message-State: ACrzQf0YIbL7e/k3o8U+5sewBGqYpvdLUDdGI1fadsJMVejvMErp+ERT
        /gvMhyqnO5Cco2yexUxNclt9Gf3SvXygRtNIWl0=
X-Google-Smtp-Source: AMsMyM5+li3a9bakkC5n17b/6lJlah/nN866x/KKBKCMPVYXqJyLNcxd8FrxUdavzi7dTrrtdSiXVwe5BunNNjFswZw=
X-Received: by 2002:a05:622a:591:b0:344:5946:8da5 with SMTP id
 c17-20020a05622a059100b0034459468da5mr8462079qtb.473.1663420340490; Sat, 17
 Sep 2022 06:12:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:5f0a:0:0:0:0:0 with HTTP; Sat, 17 Sep 2022 06:12:20
 -0700 (PDT)
Reply-To: daviesmarian100@gmail.com
From:   Marian <cj34024319@gmail.com>
Date:   Sat, 17 Sep 2022 13:12:20 +0000
Message-ID: <CAK14DJerR+K-fftvoUccBzk0NvptrBDHGyD_B3erZEN5Ursewg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:834 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4986]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cj34024319[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cj34024319[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [daviesmarian100[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
Hello
