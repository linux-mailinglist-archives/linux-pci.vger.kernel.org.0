Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26033527805
	for <lists+linux-pci@lfdr.de>; Sun, 15 May 2022 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbiEOO0Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 May 2022 10:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiEOO0N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 May 2022 10:26:13 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE705E0F9
        for <linux-pci@vger.kernel.org>; Sun, 15 May 2022 07:26:11 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id m6so13566992iob.4
        for <linux-pci@vger.kernel.org>; Sun, 15 May 2022 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZSoUlf0cPEpL7jjk6Nyt81rsCpO1vJSuE6CFnE/F0mc=;
        b=b0f/0zGlxeNvBazCWHGLnEogvpYVwdbHKraBidfsS+DkeWqlwrQIc3N1xeah/fVea+
         UUdObxZ+WzVcdANTee84Dzmz4V361Es6A4m2OMgNl/blJb+l4TfYIHN1kAGywVPDu2Kj
         BdSeR4I9ln2Eu42xsTHm+op99KhtmX+R33f0vu84er35mC4fxOyghJKiTvdiQuvfgLhj
         /oq6MijwDgaUd/A9mQLTfCIbedS373eDvTiJuXjh+s3ok+1gXW65DBpcztaFeNORrKwo
         1Yx6iTiodl/+nHw/OUUfkQCx5gNB6Q1FUKzvruaDD1If61XnfFlw2DxPdIueq+DhiAbO
         ksDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=ZSoUlf0cPEpL7jjk6Nyt81rsCpO1vJSuE6CFnE/F0mc=;
        b=4ErcnGfZ+Ml3R1uJknXU2b8jOxlvh3sWIW2Wh4vMMnqwt0iyX4L0pVFd/z5SZL0bS9
         B/IpBVjc13aVvVeEoMZLMyiE+sjtyRUgSSXyDJtAgo/ksr1jK3vv9hIiLN9AI4UNxZar
         VDBQ3jKzElB/yfnfoubIPGDHGzr51tTFlTOTXJQlzpbTr5g6PYdjYMZNMuxoE97q/jN7
         C0lgY9P6dq9teSxC/srYEOYyXhRAkMGwGB/zVMlCE/OZCIRRB9W72iebdLg5WwbfIPgl
         br/o8poK59RsiPjjwOkmQ98bY1Z2eUT9syt1l7yCLXga4ErooHZ84RzDgABv+ukgFTFu
         bFlw==
X-Gm-Message-State: AOAM5323299TO9Nftxhc3HcOaMrcBRJD+F7Tg/B6MM64rGg+9IhJoqPe
        d11q8FP09o8ZpAqlXLvKaMB+CwEK53dvPnzq9xg=
X-Google-Smtp-Source: ABdhPJzybqplS+ZUobLPmrJVOaclSJUS7jYcUxDQFT/Co8y/3rj2stEicX0BOd65DVwhvdT5DTp4HOHjMU3WMBAuCyo=
X-Received: by 2002:a6b:3ec1:0:b0:65a:499f:23a4 with SMTP id
 l184-20020a6b3ec1000000b0065a499f23a4mr5969547ioa.189.1652624771350; Sun, 15
 May 2022 07:26:11 -0700 (PDT)
MIME-Version: 1.0
Sender: soniaavis.ibrahim02@gmail.com
Received: by 2002:a05:6638:34a6:0:0:0:0 with HTTP; Sun, 15 May 2022 07:26:10
 -0700 (PDT)
From:   Frances Patrick <francespatrick49@gmail.com>
Date:   Sun, 15 May 2022 07:26:10 -0700
X-Google-Sender-Auth: aKDpS_Rf5Xd8Vv0PW65YD52D9-I
Message-ID: <CAPwBKQB_T+LRPRdJ_KENQ4AbUV2ss4wtSPLZVB2zbFosOCqN5w@mail.gmail.com>
Subject: Donation to you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, Dearest Friend,

Two Million Euros has been donated to you by Frances and Patrick
Connolly, we are from County Armagh in Northern Ireland, We won the
New Year's Day EuroMillions draw of  =C2=A3115 million Euros Lottery
jackpot which was drawn on New Year=E2=80=99s Day. Email for more details:
francespatrick49@gmail.com Looking forward to hearing from you soon,
