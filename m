Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BC024E748
	for <lists+linux-pci@lfdr.de>; Sat, 22 Aug 2020 14:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgHVMDM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Aug 2020 08:03:12 -0400
Received: from sonic309-19.consmr.mail.sg3.yahoo.com ([106.10.244.82]:42165
        "EHLO sonic309-19.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbgHVMDL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Aug 2020 08:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598097786; bh=zDths4VP2+ejYrVeCUlg33xcrCfZn0rVFT01a0bEK/U=; h=Date:From:Reply-To:Subject:References:From:Subject; b=nhMjcHQjHtQWLAkmj2fMf6FuU17kUjb20nGGpIIFZD2k/LPc6BuGdP865a6txMjj1SgQTbB5ajgBuxUj6m+9wpUGHJCzWElKpEU859KFiigg0bz/WmFVIqZKP2GI6MQt2dU2GWDCklfAk/+j4VcSWQoMyHs1OXSqOyLk/wOXLLCJhsDUvIKaHAg32O5ktmJ1JZb3BHzEfOIJbZ7rz+kC0umdj/+JYbTN51LxAekjgb1wChke9gZdpRww4l+8o7NhDTO56Vr3jOTOCPB2BGrHkJhT2EA5/2VHC1Ho6+/g9yXqzbIvHVR51y4NzfBArz4WlkHtGer0aFByB3bqXQmR1g==
X-YMail-OSG: 3pwm1swVM1mEdL_jJyAEIbtfq0u6icKz0_gm7M4T21fmo96B73kODgl8tEMY6rw
 F5IN7meBEdPvw9tdv9FRq1DXFB74CNY4Ezc51f1pVJeFVKpPr.41OK4eQ.R3sJ4bEuQxCCJPI5tM
 srHxmrWT_lXMBgj2rmAQacqcqt45jtyrNfU5CfVIOT4JJX33lPeLQxpWo_qvbmFBj_3yVYMG4aQ0
 3ZLA99WPncYktQDztc1FhOceYve3KX_tKUzQ1sfiwNy__P7OAX.NchlF9MNXmA0rY.iy1zdxyx3W
 tZbQkezSgZPmdq2xWM7ihl4RC4VMiA3dvMwfuBibHEZdN9714OQ6tTZCsh4uJS9EGQhWwXpP8rZ_
 O6Iih4lhu_NOpxQr.vkfeblGe8rO1mZyfh66ysBdqA2CFxt3r31L9TVkvORmJluI1nILZ4m5fsS_
 _.FfbZNIBVZBJlxPEMhQr90MOKNX6s0DaQyku5kznBPyvEnfFvd9lMcJuUa3zlSvvX9DVXQxwR0a
 zz8OmKLlIbsQy22uf846YW2jMsm1LhA_2_tS93leA.4EWiYXLKv5v0AtovhEgYEEJm2VoY5m9k5P
 4PksLpTo1wF4Y8o2P1ezWsBXnb3BOi0HDkci01ZkQXU.4TYWIh0TDQErzTAByCipZmOjIhy_T9Jn
 Fp4swNMMt1alaWeDJo6v5ySVxwbmleBQjGYz2Kg5A5b2pSN9NkU71emrG2ka1Ku1UZstjt5sGR.7
 kdhYybQHG27l2UCPKykHIIyRq0iAbF2OkN.Tvirnp6ZJ5HV7tVSZ2KiScCwswgETNKlOKrXrkvot
 PtiEY3WSqsmrxNOCi5TJv0rqKyloTFDOIXRL9lw1IJZx1LXeyxDvKsfPH5Tohu0JgZCb7FcV.dOa
 VQOThdKfCTBoWQss6oJBYduq1VbzI.n8S4N3H4pqyBAmhqPkp3KR1nAoP_hvXS7x_KMGNoDGFsS1
 KtcqJWwmiiG9FR86rm6c0PqnR9kpT3AunZG2WhdGJzOOa3E1YhyVY0htpxl5sxGIYwGA3zEm96oW
 aYAeCRx2EFLQUZSt1jxAgcuNxiMjLxlfF1ndUHTi15u71beHtv1WyEX1DuFDfhsTL5hD4nEMjb.r
 3O9qMh.v7aRqoALYy8r8sH7YTdgakJ4ug2fJSLmuBlEwVvJuCUCCxO_VsQEmj1nNKXqGB3eIGYJM
 bpLNFawukzmriI2VUJK1V4uVtkJI7g2P99DHGuuzoqA.l3T_lPDoiPIk8qxZMf62l1on.nehlSkm
 bz8vfm5H0x86p4WekJcWdKR4K.gb1yvDAbfIrDa47YRBZhOItevBsx8G_gSc5mMn4U2yZKe1nYQ6
 lkHdjxE_aE8L19srMMmPRQDEwEikSN_37OPk9WGGdgMvfDoNDI.jTNPAhMu0uND7pIA1zo96hNJ6
 O9PdgzP2QMDEDc9NwQ99qrQuzXsj51C5uLrr5GCC88ClcZtBT2pnvI_szjDTLKOrPFt9OLDHxLPr
 hSNTe2G0QowWdsQ4.ttXIFEp4GSTPhBsH8DtXKGTSXWdFsLml
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.sg3.yahoo.com with HTTP; Sat, 22 Aug 2020 12:03:06 +0000
Date:   Sat, 22 Aug 2020 12:03:02 +0000 (UTC)
From:   "Mrs. Kim Hong Yeoh" <kimhongyeoh501@gmail.com>
Reply-To: kimhongyeoh502@hotmail.com
Message-ID: <2044411137.3364336.1598097782598@mail.yahoo.com>
Subject: With Due Respect,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2044411137.3364336.1598097782598.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Dear Sir / Madam,

I am Mrs. Kim Hong Yeoh, Working at MAYBANK (Malaysia) as the Non-Independent Non-Executive Director and Chairman of Maybank. During our last banking Audits we discovered an abandoned account belongs to one of our Foreign Deceased Customer, Late Mr. Wang Jian, The Co-founder and Co-chairman of HNA Group, a Chinese conglomerate with significant real estate ownerships across the U.S., died in an accident while on a business trip in France on Tuesday.

Please go through this link: https://observer.com/2018/07/wang-jian-hna-founder-dies-tragic-fall/

I am writing to request your assistance in transferring the sum of $15.000.000.00 (Fifteen Million United States Dollars) into your account as the Late Mr. Wang Jian Foreign Business Partner, which I am planning to use the fund to invest for public benefit as follows;

1. Establish An Orphanage Home To Help The Orphanages Children.
2. Build A Hospital To Help The Poor.
3. Build A Nursing Home For Elderly And Widows People Need Care & Meal Support.

Meanwhile, before I contacted you I have done personal investigation in locating any of Late Mr. Wang Jian relatives who knows about the account, but I came out unsuccessful. However, I took this decision to use this fund in supporting the Orphanages Children, Widows, Less Privileged and Elderly People Need Care & Meal Support, because i don't want this fund to be transfer into our Government Treasury Account as unclaimed fund as the law of my country abiding.


I am willing to offer you 30% from the total fund for your support and assistant in transferring the fund into your account. More detailed information will be forwarded to you to break down explaining how the fund will be transferred to you.

Waiting for your positive response.
best regards
Mrs. Kim Hong Yeoh
