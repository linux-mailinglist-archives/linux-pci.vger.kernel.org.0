Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D3784E48
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 03:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjHWBhR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 21:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHWBhQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 21:37:16 -0400
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 18:37:14 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB403E46
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 18:37:14 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-ff-64e54a4ceadf
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 80.3A.10987.C4A45E46; Wed, 23 Aug 2023 04:52:45 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=hNYr6cFMYwQeGRs4CnYcKcCt0qwvzpcI5ZrI9JbxVcTPkd/ohgEYrZNAhdIQemcDm
          JCA9m/H34it6f/By5U5rfHrG7qwalPtpUySUEl20Uy9BH3ZoHDHk+E2pBQXCaK0iY
          Qg9vO7KsO3c2qDteyOudR4Q0n+AtQvqVf558DUjMk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=WkqUsnBo3AfL4pczW8w2v7q2ZtXqxvyF19EccskHMXHq30idthjZdULLlYiNXQh5S
          hU9xHFfVUFEqAjmu9Q/TCVGDnmX9cD9OnwjqQ9S1iBZ/XhQyVkNgwRjtNjMIULGtl
          cNH2DeYDrgvX24VhD0QYIuVUcGLLv4lE6ibuq2Fq4=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:06 +0500
Message-ID: <80.3A.10987.C4A45E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-pci@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:19 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsVyyUKGW9fX62mKwemd3BZn5x1nc2D0+LxJ
        LoAxissmJTUnsyy1SN8ugStjyboLLAW7mSva+hexNDA+Zupi5OSQEDCR2DrxB3sXIxeHkMAe
        Jon13zrAHBaB1cwS/69dZ4JwHjJLbHr7jAmirJlR4k/HTTaQfl4Ba4kVhxaxg9jMAnoSN6ZO
        gYoLSpyc+YQFIq4tsWzha+YuRg4gW03ia1cJSFhYQEzi07RlYK0iArISHy/vAWtlE9CXWPG1
        mRHEZhFQleic8wPMFhKQkth4ZT3bBEb+WUi2zUKybRaSbbMQti1gZFnFKFFcmZsIDLZkE73k
        /NzixJJivbzUEr2C7E2MwEA8XaMpt4Nx6aXEQ4wCHIxKPLw/1z1JEWJNLAPqOsQowcGsJMIr
        /f1hihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFeW6FnyUIC6YklqdmpqQWpRTBZJg5OqQbGy7f1
        XnHZZW49Xqv00/G92OEXNXOLW+sZ5hU8tD8wbbupXJQG+yP/IO+5xXmzF+6ZyfzmmkjChXnL
        mKR2rjh0tLx/W23AkaB74dP0uk2430W3H1BI4JaWfl+aPuvWjA2TJ8yN/SN8dHWE7m/D3xf/
        ma0NVL766EGc0cSjSfvt3x7i9NRzYzM0V2Ipzkg01GIuKk4EAKo7iuBAAgAA
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

