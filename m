Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4574C3A2E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 01:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiBYAPX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 19:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiBYAPW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 19:15:22 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF032692F8
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 16:14:51 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2d07ae0b1c4so16445317b3.11
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 16:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6Aoa2p8oqvyLECUFsDvLgzisCHShH+eDoTjJ8dbbIxE=;
        b=KzwPv1juJkM45v774F/tGkyjpOs5hdZZpEhNFp44VyLk0qN4Vnt5WOJhi1P8WITSJg
         2Dk98iPP13d33pLmQfh9khpWDdohLjRwnq8SsoqejxM6nUOXxk96htgVe9tw5e3uejG+
         CFA+QD+ImuijU8Llsk5WruKtPzisepPMjumVMkCo+1QHtyFF8QqxwmQk5cbCkhtnyguc
         5qy49zBBouUCyB5Cuvgf0pliSTEkNYUiAUVNK9GByuj+7o7B0Huhzle/D6CVG58h8v4M
         mHANYLZ7zNRavJRRcEjJtaVPZWgS/b4/7TI+9tQIGY+z+TSMCLDug6sjnTjpf4PiFgm/
         uaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=6Aoa2p8oqvyLECUFsDvLgzisCHShH+eDoTjJ8dbbIxE=;
        b=36rTVfRA8Qyhv5wHGfkP0/nlRPuFZxse6WBiYO56miAehWXvH8AWvUCzJpfOJHH0WB
         jKl32EuQU3J0fU+dk8jveBVhMNiljpOOLkVmteVmy3pZab/2cWfyF1uTXjSyLZNyeoZu
         89X8j2ImrXaoaTdWpCzJrgFCHNPXSbg8dt8N7brge4Vy3z1Tlz9IP37oNST85ehFIasb
         dH7sNK/vEFnxpX0SToAYzGRO8PsUSfY6eVNo7l3N4EvpWi8w/9stekVi/lXjkI2MRI37
         4Vf8/vyMOuE00KYwFMGP2jsGtwSxRsOkcCk3HGvTHxV3KAQHwZwrcpNQ7gRnldFJLLRg
         5KwA==
X-Gm-Message-State: AOAM531oPPWnZJ5Iy0v/cPTiPxAI1h8FJtI+O5fW8Vn165Qu5GJonQNn
        a3nTZxdMhT8LnCQXDcIcA8uNL1mD5T52sgUb9ds=
X-Google-Smtp-Source: ABdhPJxVjPnm5WwG8IlMXSGyS7x4IgDJv6iP/c6y8WTefAReXC1jHtrg25gBT2HLhHh5ymWg9225QB2YYR0Cw9B1Gy8=
X-Received: by 2002:a81:84:0:b0:2d7:9581:b7d2 with SMTP id 126-20020a810084000000b002d79581b7d2mr5066294ywa.161.1645748090315;
 Thu, 24 Feb 2022 16:14:50 -0800 (PST)
MIME-Version: 1.0
Sender: anitajoseph199211@gmail.com
Received: by 2002:a05:7110:499c:b0:15e:c83a:ee7c with HTTP; Thu, 24 Feb 2022
 16:14:49 -0800 (PST)
From:   "Dr. Aisha al-gaddafi" <dr.aishaalgaddafi09@gmail.com>
Date:   Fri, 25 Feb 2022 00:14:49 +0000
X-Google-Sender-Auth: Epsi4X6svLhHOVVdmMPLtxngKQ0
Message-ID: <CAEdDLtHeASgshj3qrnO3aZmoOEnRB529jV2knrHMMwM2s7oFaw@mail.gmail.com>
Subject: =?UTF-8?B?6Im+6I6OwrfljaHmiY7oj7LljZrlo6vjgII=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5826]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [anitajoseph199211[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [anitajoseph199211[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGF2ZSBhIG5pY2Ugd2Vla2VuZCwNCg0KSSBhbSBEci4gQWlzaGEgYWwtR2FkZGFmaSwgdGhlIGRh
dWdodGVyIG9mIHRoZSBsYXRlIExpYnlhbiBwcmVzaWRlbnQsDQoNCmkgYW0gY29udGFjdGluZyB5
b3UsIGJlY2F1c2UgSSBuZWVkIGEgUGFydG5lciBvciBhbiBpbnZlc3Rvcg0KDQpXaG8gd2lsbCBo
ZWxwIG1lIGluIGludmVzdGluZyB0aGUgc3VtIG9mICQyNy41IE1pbGxpb25VU0QgIGluIGhpcyBv
cg0KaGVyIGNvdW50cnk/DQoNClRoZSBmdW5kcyBhcmUgZGVwb3NpdGVkICBpbiBCdXJraW5hIEZh
c28sIHdoZXJlIEkgYW0gbGl2aW5nIGZvciB0aGUNCm1vbWVudCB3aXRoIG15IGNoaWxkcmVuIFBs
ZWFzZSBhZnRlciByZWFkaW5nIHRoaXMgbWFpbCB0cnkgdG8gIGNvbnRhY3QNCm1lIHRocm91Z2gg
IHRoaXMgbXkgcHJpdmF0ZSBlbWFpbCBpZiB5b3UgcmVhbGx5IHdhbnQgbWUgdG8gc2VlIHlvdXIN
CnJlc3BvbnNlDQoNClRoYW5rcywgSSBhd2FpdCB5b3VyIHJlc3BvbnNlDQoNCkRyLiBBaXNoYSBh
bC1nYWRkYWZpLg0KDQoNCg0KDQoNCuelneS9oOWRqOacq+aEieW/q++8jA0KDQrmiJHmmK/lt7Lm
lYXliKnmr5Tkup7nuL3ntbHnmoTlpbPlhZLoib7ojo7Ct+WNoeaJjuiPsuWNmuWjq++8jA0KDQog
IOaIkeato+WcqOiBr+e5q+S9oO+8jOWboOeCuuaIkemcgOimgeS4gOWAi+WQiOS9nOWkpeS8tOaI
luaKleizh+iAhQ0KDQroqrDlsIfluavliqnmiJHlnKjku5bmiJblpbnnmoTlnIvlrrbmipXos4cg
Mjc1MCDokKznvo7lhYPvvJ8NCg0K6LOH6YeR5a2Y5pS+5Zyo5biD5Z+657SN5rOV57Si77yM5oiR
54++5Zyo5ZKM5a2p5a2Q5YCR5L2P5Zyo6YKj6KOh5aaC5p6c5oKo55yf55qE5biM5pyb5oiR55yL
5Yiw5oKo55qE5Zue5aSN77yM6KuL5Zyo6Zax6K6A5q2k6YO15Lu25b6M5ZiX6Kmm6YCa6YGO5oiR
55qE56eB5Lq66Zu75a2Q6YO15Lu26IiH5oiR6IGv57mrDQoNCuisneisne+8jOaIkeetieW+heS9
oOeahOWbnuWkjQ0KDQroib7ojo7Ct+WNoeaJjuiPsuWNmuWjq+OAgg0K
