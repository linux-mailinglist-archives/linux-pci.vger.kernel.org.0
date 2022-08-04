Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6058962B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 04:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbiHDCfr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 3 Aug 2022 22:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbiHDCff (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 22:35:35 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Aug 2022 19:35:34 PDT
Received: from lvs-smtpgate3.nz.fh-koeln.de (lvs-smtpgate3.nz.FH-Koeln.DE [139.6.1.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294D112AAD
        for <linux-pci@vger.kernel.org>; Wed,  3 Aug 2022 19:35:33 -0700 (PDT)
Message-Id: <c8230b$21d9ka@smtp.intranet.fh-koeln.de>
X-IPAS-Result: =?us-ascii?q?A2D//wDdL+ti/wQiBotaHQEBPAEFBQECAQkBFYFRARoIA?=
 =?us-ascii?q?YEWAgFPAQEBgRSBLAEBK4ROg0+IT4NDAYEpgnWLFYFjBQKPBAsBAQEBAQEBA?=
 =?us-ascii?q?QEJEgIlCQQBAYUDAVMBAQEBB4QdJjgTAQIEAQEBAQMCAwEBAQEBAQMBAQgBA?=
 =?us-ascii?q?QEBBgSBHIUvOQ1fAQEBgQw0AQEBhBABAQEGAQEBK2sgAhkNAkkWRwEBAQGCR?=
 =?us-ascii?q?kUBAQGCHQEBMxOiLIdhgTGBAYIpgSYBgQuCKQWCcoEXKgIBAQGHZ5BcgQ8BA?=
 =?us-ascii?q?oUYHROCUgSXbwICGjgDNBEeNwsDXQgJFxIgAgQRGgsGAxY/CQIEDgNACA0DE?=
 =?us-ascii?q?QQDDxgJEggQBAYDMQwlCwMUDAEGAwYFAwEDGwMUAwUkBwMcDyMNDQQfHQMDB?=
 =?us-ascii?q?SUDAgIbBwICAwIGFQYCAk45CAQIBCsjDwUCBy8FBC8CHgQFBhEIAhYCBgQEB?=
 =?us-ascii?q?AQWAhAIAggnFwcTMxkBBVkQCSEcCR8QBQYTAyBtBUUPKDM1PCsfGwpgJwsqJ?=
 =?us-ascii?q?wQVAwQEAwIGEwMDIgIQLjEDFQYpExItCSp1CQIDIm0DAwQoLgMJPgcJJixMP?=
 =?us-ascii?q?g+WQ4INgTgCMIcLjUKDZQWKVKBbCoNRgUQCk32MKIJGknQOBJF9CYVvhHaME?=
 =?us-ascii?q?KdXgXiBfnCBbgolgRtRGQ+SEopfdAI5AgYBCgEBAwmMZIEKgRgBAQ?=
IronPort-Data: A9a23:Gml2OaspHf0Tk8mj8hthFBIlp+fnVJZYMUV32f8akzHdYApBsoF/q
 tZmKTiAOaqKYjShfdsjbt+/9BgDv5bTx4M3HAdpq3oyFXsagMeUXt7xwmUcns+xwm8vaGo9s
 q3yv/GZdJhcokf0/0vraP65xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2LBVPivU0
 T/Mi5yHULOa82MsWo4kw/rrgA9iuv30pAQZsjQWDRyclAaD/5W9JMt3yZCZdxMUcKENdgKJb
 7qrIIWCw4/s10xF5uVJMlrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnZO7ZD4TF7Tqo7gmVzZgIyckLIxjyoaSdBBTseTLp6HHW17F6KwzIhpwI5UevOh3RGJJ+
 PgebjwABvyBr7vtkfTlDLIwwJhLwMrDZevzvlllxDraAPA0QJ2GX7jW+dtV9Dw5wNpUW/3ZY
 qL1bBIxPEmROEceYj/7DroCmMaM2EHEVQYEl1KpuvM2wmzK71xYhe2F3N39IIXRHJ4Fzy50v
 Fnu+m3jARYEPcaQwGbc2n2pj+7L2yj8Xeo6Erix7P1tnlSJyWVPUTUZUFK6pb+yjUvWc95DA
 08Z4Cwjqe417kPDZtnwXh6/iGWCohMXW5xcHoUS7ACL17qR+QGSBWMETyZpbN09qNRwRDokz
 FaFktrlQzt1v9W9TXOb66fRtTizETYaIHVEZiIeSwYBpd75r+kbgh/RT91uDLS4g/XrFjzqh
 TOHti4zg/MUl8Fj/6G6+03Xxju2o93KQxQz6wH/WmO+8hg/ZYirfYWk5FHXq/FaI+6xFAHb5
 iBYwpXEtbhQV8jLyXfdGb1cWe3s//maMSXRhkNzN5Yk/jWpvXWkeOh4umkkfh81a5teIGe3O
 haV5FgBvccCeSLvdaBoYpq8DNk25aflHNXhEPvTa7JmOMArLlfbpXw0PBbOhTmrzRN8yPluf
 MreacmzDG4XDrl75DWzTuYZl7Qsw0gWnzuJH8inlkn9iOLAPifTFOxVaQPfK7t89KyboR3Y9
 MtDH8SPwhRbFub5Z0H/q9ZJdwhWdCVhXMio8ZURK7XTe1I3XTtkE/DOwKssfJF5t6tQn+bMu
 Hq6Xydwk1Gl3SedcVnTNyo6MO21BNAi9iJiZX1pYROw1GcieYuo8bs3eJ4+fL1h/+tmpdZ2Q
 uMedtSbAvNVRyzO4SgbYIPmrI16chaDigeHPi7jaz86F7ZrQAvN8db4OBDm8C0fJiWyvMo65
 ban02vzSp0EQw9rEIDbbPau51y0tHkZ3ul1WiPgKd5UfE7l7M5wJirwkvYfLMQFKBGFzTyfv
 y6dBhAcruDR5Yw07MXYra+BpoatVeB5GyJyEWDQ4LCrODfT4GuvyKdPVe+JeXbWU2acxUm5T
 f0NlK2kaKFBgk5M9oQkT/Blzec94NbroflWw2yIAUkncXykAZ5ZGFCf+/ITjali/o9f4xqXf
 3C2r4wy1aqyBC/1LLIADFN7M7XfjaxNx2C6AecdfR2qvn4plFaTeRsDb0DX4MBIBOItWL7J1
 9vNr+Y6xmRTYDIVP82dgyRV8WvkwpcoDv185sBy7GPDrA0x1lEKW5zdDCKz35yUd81MO00rK
 1epaEv+a1d0nxSqn4IbTySl4Aakrc1mVdAj5AZqy661stTEnOQr+xZa7C46SA9Ypj0ejb8iZ
 zUyaxYodPvVl9uNuCSldz/xc+2mLELCknEdN3NTyDOxo7SACT2dfDxsY45hAmhFojsEJ1C3A
 410OE6/CG2zJ5GgtsfDcUJotuD4Rtx87UXMn9q8FMSYGZYhZzf5kMeTiZkg9HPa7AJYrBOvm
 NSGC84rNPCkbHJN8v1jY2RYvJxJIC25yKV5aakJ1Ms08av0J1leBRDmx5iNR/5w
IronPort-HdrOrdr: A9a23:IAEcnaDJKR0fi07lHem755DYdb4zR+YMi2TCHihKJSC9Ffb0qy
 nOpp8mPHDP6Ar5NEtApTniAsO9qBrnnPZICO8qTNSftMyMghrMEGgI1+TfKlPbdREWjdQtt5
 tdTw==
X-IronPort-Anti-Spam-Filtered: true
THK-HEADER: Antispam--identified_spam--outgoing_filter
Received: from p034004.vpn-f04.fh-koeln.de (HELO MAC15F3.vpn.fh-koeln.de) ([139.6.34.4])
  by smtp.intranet.fh-koeln.de with ESMTP/TLS/DHE-RSA-AES128-SHA; 04 Aug 2022 04:34:03 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Charity Donation
To:     You <mackenzie-tuttle@ca.rr.com>
From:   "MacKenzie Scott" <mackenzie-tuttle@ca.rr.com>
Date:   Thu, 04 Aug 2022 03:34:01 +0100
Reply-To: mackenzie-tuttle@californiamail.com
X-Priority: 1 (High)
Sensitivity: Company-Confidential
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
  My name is MacKenzie Scott Tuttle; I'm a philanthropist and founder of one of the largest private foundations in the world. I'm on a mission to give it all away as I believe in ‘giving while living.’ I always had the idea that never changed in my mind — that wealth should be used to help each other, which has made me decide to donate to you. Kindly acknowledge this message and I will get back to you with more details.

Visit the web page to know more about me: https://www.nytimes.com/2022/04/10/business/mackenzie-scott-charity.html

Regards,
MacKenzie Scott Tuttle.
