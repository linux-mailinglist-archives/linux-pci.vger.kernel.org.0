Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77893268A89
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 14:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgINMBu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 08:01:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:46733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgINLk4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 07:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600083556;
        bh=f0dZy9+FhBEO7GSEaqvJXC6YpjJ355zoFG9pqHjP6XQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HJsSfvX65CWO6/YQhM6PdixgM5ul7nhZq6sfszpMOfbupJVK3byjAYuuSUuWdnW0i
         Fk5bqywBfOhqD5+sfa30P6VnMchqmYWKfL9IVBuq9sx/542+fMQ1flJHxAGgKUHD//
         mDItSidgQTNW0lUf9UVAY9OQ9CMC8IZduNt7nwtM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.208.209.101] ([80.208.209.101]) by web-mail.gmx.net
 (3c-app-gmx-bap20.server.lan [172.19.172.90]) (via HTTP); Mon, 14 Sep 2020
 13:39:16 +0200
MIME-Version: 1.0
Message-ID: <trinity-a791b919-956f-4cde-a496-919d4f3f2ba9-1600083556775@3c-app-gmx-bap20>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yong.wu@mediatek.com
Subject: Aw: [PATCH v6 0/4] Spilt PCIe node to comply with hardware design
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Sep 2020 13:39:16 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20200914112659.7091-1-chuanjia.liu@mediatek.com>
References: <20200914112659.7091-1-chuanjia.liu@mediatek.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:0PDB+aZRuNST62kZwEGOyCa7pLdlcYqnwgLUj7ZrKDks0V8Xio4QC3Ubo+Np/Ci+Ityxp
 h4alMQQsNmo4MFcxcJp8R6rh4h0FY1YPTSk0QPidhgQxb2/iyNahEr1dz/wrSg6uCXyefnyUCQju
 TYlsfLu/ioVfRJ+7GnN2a8CtWXAnwTvWd+viD1itLrq+ju6/mVtKkHFtjHZnPpig8AqEyKYFAABb
 8Xr3KxXPX5WteQV82FDNbcYn3VcjiNqA7Nes5HC/Bh/h4VCI/cgsQvt8JWWJf7iMtjzVkr6WWKVJ
 cw=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0nAv7gzaFy4=:U9oXlmnt8K3fDivQOfT/rL
 7cIJQ/ly0VcrieuCRrOv5IBVEhtbQVyDMsMV6ewbuurkifr+YrE9LIegWiTHsGIRfjWsGOHtQ
 yNmqTG74LxdVkTL7pkED2B+V4VddIJ35u+7zfAGKxDOW/kzJiFsgbaGvdAxPdEBxIUpeD4iO7
 yk9ReHHwwPH4gS2VvPLHpbm/inxzx9LA0oOv0wSZF/d0eYp59W8IMwMH8TvzCJu7ZW2Wou2fP
 1Pgq23oWdglrooGlQo6WhUXOwUchKwN4DLzZLt9dpSAPVkEjgzlDZx/zCGYdS0M5CpgY1VCo0
 AGrtS50O52QHU/z+ROezKYk4cC7RKdVOtjxKjs7qmgKL6oKae/6anpDtk8o8AvO5bh7T5qXGZ
 COWSUTyLQOHBG8Kk0vOW56xxeQJ3aFAfDr18eqFkvI5+wNxTkwfS7q+++jDg7Klgzmp6JaoXW
 skrwilxuTQz37tv1fa2GDRLJcGMwQnGIqx/+pc+mjlyVVakJ0RsZs5xa251whzou8Tth9e7B5
 ny462jTWHaZEBHHaNhb2tX6rXLeFwsZEvKcvcQ0TK/4zUmq/8Y+q20M4YkRkyNY1JOyhcwqnp
 jqodc5EGMTekn+Cl7eTAq8/PJXs9FLJBkhPR0ogHq4XvlW7SYJbwLTZxNNucBxbeIs6+iwAl6
 YYnT3K5VbS510xMESLC2MQ3pS1aj9e7iOACrAZGIuOFQoKnSfR5vzOPLjPt3NGK7CY7k=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Betreff: [PATCH v6 0/4] Spilt PCIe node to comply with hardware design

just if you need to make another version (as it is only the cover-letter) you can fix the typo in subject ;)

regards Frank

