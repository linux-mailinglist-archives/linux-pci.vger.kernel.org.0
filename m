Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28154494E36
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 13:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbiATMtK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 07:49:10 -0500
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25577 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbiATMtK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 07:49:10 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1642682941; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=P0TpBspO/zhTlEltehIaKc9tc8RjxfRYm/Yi3sFSkneTwLrL8ClCLEhHzJxvslz/Aqc0mUVZZfK6UZq5Rc5GBgvzt9wtECftig7FIR5cuJvDoeiaKj/PKI/E7Sph0yHtanaXMVUNnWcXaULMfZjToo+88lHC7b1GUv9gzOmcIvI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1642682941; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=yUTsA+c6hb9Je+Diep+8AkbZJAUlOJu01TX1wUceaK4=; 
        b=ToGrsRKAN0by9rcDQVVssP+8L3VBdGCAiD70UZAIk3kjRCSc28MLU4uXEfeg8nBejpIXpa4rAkr80y5K6FiLQ21kYNQC1n8g0y0TeaQtMl9idWs/qxoNIA/IOAdWi1e2QWc6vxBVi/BRDCsR4hlFgxElRkG+SyXpyNwAFhITpOY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642682941;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=yUTsA+c6hb9Je+Diep+8AkbZJAUlOJu01TX1wUceaK4=;
        b=gaGeVn7KLpqUR/DrAVvSgLwKGX4zeqQ5jKLJ4anFlT+QL7ZElHN2V8Yteh7kQoyr
        8h0EoWrB487HdWkd80lx+GLZfheEUUfKqZhXb9eqsr8JoZQUn+4J/kTcOMZGv96QAKs
        0HecfBOL0gmSWt9vu4bVoJ03qlBduDJY3Z1vDov0=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1642682939409202.43932537062926; Thu, 20 Jan 2022 04:48:59 -0800 (PST)
Received: from  [203.218.243.128] by mail.zoho.com
        with HTTP;Thu, 20 Jan 2022 04:48:59 -0800 (PST)
Date:   Thu, 20 Jan 2022 20:48:59 +0800
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17e778877f2.d177f3fb1187.3593848989432373458@zohomail.com>
In-Reply-To: <YelOKkg4SIiRJmz5@kroah.com>
References: <17e76f86155.1222b3923123229.7199263965880267375@zohomail.com> <YelOKkg4SIiRJmz5@kroah.com>
Subject: Re: [PATCH V3] misc: pci_endpoint_test: simplify endpoint test read
 and write operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 ---- On Thu, 20 Jan 2022 19:57:30 +0800 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote ----
 > On Thu, Jan 20, 2022 at 06:11:36PM +0800, Li Chen wrote:
 > > Introduce pci_endpoint_epf_transfer_data to simplify
 > > read and write operations.
 > > 
 > > Signed-off-by: Li Chen <lchen@ambarella.com>
 > 
 > Does not match the From: line.  Please read the documentation for how to
 > fix this up and add a From: line to the email body itself.
 > 
 > thanks,
 > 
 > greg k-h
 > 

Thanks! This is fixed in patch V4.

Regards,
Li
