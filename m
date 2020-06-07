Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F971F0A38
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jun 2020 08:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgFGGSf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Jun 2020 02:18:35 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:57224 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbgFGGSd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 7 Jun 2020 02:18:33 -0400
Received: by ajax-webmail-mail-app3 (Coremail) ; Sun, 7 Jun 2020 14:18:15
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Sun, 7 Jun 2020 14:18:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Marek Vasut" <marek.vasut@gmail.com>
Cc:     kjlu@umn.edu,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] PCI: rcar: fix runtime pm imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <5cf73d31-33ab-b9ba-c9d5-faa3977484eb@gmail.com>
References: <20200520082228.26881-1-dinghao.liu@zju.edu.cn>
 <5cf73d31-33ab-b9ba-c9d5-faa3977484eb@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <176a80c.fc77b.1728d6dfd9b.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgDnX0OnhtxeMzVaAA--.20998W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgUABlZdtOcIbQAQss
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUblCS07vEb7Iv0x
        C_Jr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVCjxxvEw4WlV2xY6xkI7II2jI8vz4vEwIxGrwCS07vE42xK82IY6x8ErcxFaV
        Av8VW8uw4UJr1UMIAIbVCF72vE77IF4wCS07vE4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lV2xY
        6I8I3I0E5I8CrVAFwI0_Jr0_Jr4lV2xY6I8I3I0E7480Y4vE14v26r106r1rMIAIbVC2zV
        AF1VAY17CE14v26r1q6r43MIAIbVCI42IY6xIIjxv20xvE14v26r1j6r1xMIAIbVCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lV2xY6IIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIAIbVCI42IY6I8E87Iv67AKxVWUJVW8JwCS07vEIxAIcVC2z280aVCY1x0267AKxVWU
        JVW8JbIYCTnIWIevJa73U
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiA+ICAKPiA+ICBlcnJfcG1fcHV0Ogo+IAo+IFlvdSBtaWdodCB3YW50IHRvIHJlbW92ZSB0aGlz
IGxhYmVsIHRvby4KClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgb3V0IHRoaXMhIEkgd2lsbCBmaXgg
dGhpcyBpbiB0aGUgCm5leHQgdmVyc2lvbiBvZiBwYXRjaC4K
