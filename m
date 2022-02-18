Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7484BB03F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 04:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiBRD0O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 22:26:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiBRD0O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 22:26:14 -0500
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B148D1B4F30;
        Thu, 17 Feb 2022 19:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645154754;
        bh=F/tGiAdsjuQ0q4Nj/0VGkH32X+GI2mQPc8R61JxSmTM=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date;
        b=yZ0hbSooVqyWKuBRGQaqVlGG8jHd3aDQZGS8U0TbDj+XR7yZ+TRxi33d0ZjIXh0d/
         KWcZVJW0nZY1yolJsmExW9sr8XPZq4mHHnQe1OF7V2++jbEGlPNw7nHrFYbEHSEGj5
         mpbivzb8BmeceA07KuPS6kRrm6t0I4OD72i0vAt4=
X-QQ-FEAT: oHWrrGTW1dDmmdYeXRw4YEXQp3CWT7El
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMAILINFO: M/OchVwRIgcXcgiSPOYTSo67/UC58rNJiHD1eqUIupMUylOlig6Pg1EwAXQBQE
         P6TGvEezTR3nSPgIyvHLLTB/NgGsc/ZT/EgTyJPs8lu8nT8hTxfJ1dZznTw//hKsMOVl9IP1C6gzu
         Iw0ysO40N6oDfdmeWq2rKQGYka2vxDfdeveevc7HGDXO2cxSNRxWBHnJO4W/wGYU7/wjGUMgz8TmG
         cnb33k/Dib38edsTFRNARG8gJP4zhdXsT8JztQmrOi+OkuyTYhzffj++b6eUJFAxmglFydc4hI0cy
         UMohn1THfvyuzgdgk02GVsLaXJkcwECz7mlJSFwoVrbs7TijQ8qQEezvty4TEZnDtrhBSlmf3S7Xy
         3zEWNAvRQYlyeA3UOx7oFprcp5uMmUY1+j9tZWRFNqKI4jSaxki5r7Tae7RA2Dca4wnk0WPgTAQzX
         gkXDlmfSZXYHsoVAQ7Y+q5mFqcXLnhQE+4keROvATyB5XA/9CfpgeQBrFHe0Rk5TR5PKHOU2Q0fFa
         gg6rgEo7vNUYw6jCajycXUl59yqxjM+SoqMvAww7L8U0EHbNfwewQUKocaV3+VikweiQJPizH4/pT
         jQGj0nFaHpcag6xcfxW+srKEuCwNWziUzcEJcWCcbE14wv9slfR8IDpEtft4LCH0+h40H6HgA174M
         tk+nw2XjSMVgBhYGTL2BommBGkuCFRMtTy3g0QEIAtoMKzZ6T2pSZp3LtPxuEwKE3vGg/BMeQ8JR0
         rsAPPrSLwXR324wX3m67zrRtOl//efHbKAjTbM6OQckSf8Trw328cSI2PEKk81+6Fah1xj5pKN2xX
         +peIrzlq7vlD72jLTgIvWlDlrg87liYouU3ohBA11sVaec6z3rWPYqB+3Khgt4pTSA==
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 111.47.122.156
In-Reply-To: <17f0ac8707d.e967ff2c113435.3595297833916391134@zohomail.com>
References: <tencent_CA4766945C568E210AA2701525957F041007@qq.com>
        <17f0ac8707d.e967ff2c113435.3595297833916391134@zohomail.com>
X-QQ-STYLE: 
X-QQ-mid: webmail813t1645154753t3342158
From:   "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
To:     "=?ISO-8859-1?B?TGkgQ2hlbg==?=" <lchen.firstlove@zohomail.com>
Cc:     "=?ISO-8859-1?B?a2lzaG9u?=" <kishon@ti.com>,
        "=?ISO-8859-1?B?bG9yZW56by5waWVyYWxpc2k=?=" 
        <lorenzo.pieralisi@arm.com>,
        "=?ISO-8859-1?B?a3c=?=" <kw@linux.com>,
        "=?ISO-8859-1?B?YmhlbGdhYXM=?=" <bhelgaas@google.com>,
        "=?ISO-8859-1?B?bGludXgtcGNp?=" <linux-pci@vger.kernel.org>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] [PATCH] PCI: endpoint: functions/pci-epf-test: fix a potential memory leak
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Fri, 18 Feb 2022 11:25:53 +0800
X-Priority: 3
Message-ID: <tencent_E7FF1CE4823926578BC38502335C4169EB05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_EXCESS_BASE64,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

LS0tLSBPbiBGcmksIDE4IEZlYiAyMDIyIDExOjAzOjAyICswODAwICBMaSBDaGVuIDxsY2hl
bi5maXJzdGxvdmVAem9ob21haWwuY29tPiB3cm90ZSAtLS0tCj4gVGhpcyBpcyBkdXBsaWNh
dGUgIHRvIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTdlZDgxNmI2ZjMuZDRmYjQ0
ZmI2OTc0NS4xMDQ4NDQ3ODQxNzIxMzgyOTIwQHpvaG9tYWlsLmNvbS9ULwoKT2ghIEkgYW0g
c29ycnkgdGhhdCBJIG9ubHkgdmlld2VkIHRoZSBjb2RlIGluIHRvcnZhbGRzL2xpbnV4IGdp
dCAKcmVwb3NpdG9yeSwgYnV0IG5vdCB0aGUgbWFpbCBsaXN0LgpUaGFuayB5b3UgZm9yIHlv
dXIgcmVtaW5kZXIuCgpSZWdhcmRzLApXYW5n

