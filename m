Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1999361292A
	for <lists+linux-pci@lfdr.de>; Sun, 30 Oct 2022 09:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJ3Ijm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Oct 2022 04:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJ3Ijl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Oct 2022 04:39:41 -0400
Received: from fx306.security-mail.net (smtpout30.security-mail.net [85.31.212.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6296A0
        for <linux-pci@vger.kernel.org>; Sun, 30 Oct 2022 01:39:37 -0700 (PDT)
Received: from localhost (fx306.security-mail.net [127.0.0.1])
        by fx306.security-mail.net (Postfix) with ESMTP id E37DA312B1C
        for <linux-pci@vger.kernel.org>; Sun, 30 Oct 2022 09:39:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
        s=sec-sig-email; t=1667119175;
        bh=h9v36uR/+PgLshxmrPJH89X6FE4JeipAiLOEa2J4iRM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject;
        b=HaKGT8aBOpSfIa/lCvpt3CI3U43Ev8nOmhUFl5BnII90yVTNc3Qqmxlp4hq6AH6yj
         lM85kZLSWavCSy6J+oGaZxIJR73+s1WTE0Xw87PWgMEcZuCtdtAOAsoLycpamOKYps
         WE3qOZElFSWE9swLS0ZsatxvY66ALZ52TdXh/HIQ=
Received: from fx306 (fx306.security-mail.net [127.0.0.1]) by
 fx306.security-mail.net (Postfix) with ESMTP id A9C4C312B25; Sun, 30 Oct
 2022 09:39:35 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx306.security-mail.net (Postfix) with ESMTPS id 2EE03312B24; Sun, 30 Oct
 2022 09:39:35 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 02BBD27E0267; Sun, 30 Oct 2022
 09:39:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id D8A0827E02C8; Sun, 30 Oct 2022 09:39:34 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 A13bI_SsvGbu; Sun, 30 Oct 2022 09:39:34 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTP id BDEE227E0267; Sun, 30 Oct 2022
 09:39:34 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <5196.635e3847.2cade.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu D8A0827E02C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1667119174;
 bh=zSYQyCy0bsfqPuG7SZ5cMDa8o7qeMNDxE9bO+09UwJI=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=4aFdK63phSa6xbQKyDynBmgGybpZUsHhzIDbID8IcfpVMXFNj85EjsJmZyPXEix1b
 qjRlNETdV9COEXuG8j73CuXKUCtBmlB5AYbSeqXGaYopry3d+OAqhuBq7vSjXDM6j/
 bwBxvEzN1dEl+q9wR99Fy9dY42xdUPhR5RNlC0MZ98qI81DpiUFzbH/qQ5263AmMM4
 YK2mGwMJKR07CbNcdJYwquxuv2thAcj4mX9GMf6o3LkpACBDqUDudVuTQ74VXoy22A
 6jq5el09kKYv1iCBX2ItZK+7+ibFKZY2KTHrzWiNGPzPfJhF3TGXM8+vjNM3+k1fzJ
 ekU4DnMiEcYzQ==
Date:   Sun, 30 Oct 2022 09:39:33 +0100 (CET)
From:   Alex Michon <amichon@kalrayinc.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     michael haeuptle <michael.haeuptle@hpe.com>,
        CS1PR8401MB07283E5AFD950C136FFC565E95C60 
        <CS1PR8401MB07283E5AFD950C136FFC565E95C60@cs1pr8401mb0728.namprd84.prod.outlook.com>,
        dstein <dstein@hpe.com>, linux-pci <linux-pci@vger.kernel.org>,
        lukas <lukas@wunner.de>
Message-ID: <496564878.633246.1667119173775.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20221030082818.GB4949@lst.de>
References: <492110694.79456.1666778757292.JavaMail.zimbra@kalray.eu>
 <20221030082818.GB4949@lst.de>
Subject: Re: Deadlock during PCIe hot remove
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 9.0.0_GA_4373 (ZimbraWebClient - FF105
 (Linux)/9.0.0_GA_4373)
Thread-Topic: Deadlock during PCIe hot remove
Thread-Index: Ghub1TcnbDBLq0craJEE8UVPRql0+Q==
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorry, I wanted to reply to this thread: https://lore.kernel.org/linux-pci/CS1PR8401MB07283E5AFD950C136FFC565E95C60@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM/
but it looks like something went wrong with the email delivery.

----- Original Message -----
From: "Christoph Hellwig" <hch@lst.de>
To: "Alex Michon" <amichon@kalrayinc.com>
Cc: "michael haeuptle" <michael.haeuptle@hpe.com>, "CS1PR8401MB07283E5AFD950C136FFC565E95C60" <CS1PR8401MB07283E5AFD950C136FFC565E95C60@cs1pr8401mb0728.namprd84.prod.outlook.com>, "dstein" <dstein@hpe.com>, "hch" <hch@lst.de>, "linux-pci" <linux-pci@vger.kernel.org>, "lukas" <lukas@wunner.de>
Sent: Sunday, October 30, 2022 9:28:18 AM
Subject: Re: Deadlock during PCIe hot remove

On Wed, Oct 26, 2022 at 12:05:57PM +0200, Alex Michon wrote:
> Hello, 
> 
> Is there any update on this bug ? 

What is "this bug"?




