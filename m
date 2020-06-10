Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA651F56AE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 16:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgFJORS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 10:17:18 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:54731 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgFJORS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jun 2020 10:17:18 -0400
Received: from [192.168.42.142] (unknown [212.29.212.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPSA id 3EDB044004C;
        Wed, 10 Jun 2020 17:17:16 +0300 (IDT)
Subject: Re: [RFC PATCH] pci: pci-mvebu: setup BAR0 to internal-regs
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris ackham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200608144024.1161237-1-sh@tkos.co.il>
 <20200608214335.156baaaa@windsurf>
From:   "Shmuel H." <sh@tkos.co.il>
Message-ID: <ae84b87c-665b-7619-7cb0-a1fd58b17d8f@tkos.co.il>
Date:   Wed, 10 Jun 2020 17:17:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608214335.156baaaa@windsurf>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 6/8/20 10:43 PM, Thomas Petazzoni wrote:
> Some Armada 370/XP platforms really do use 0xd0000000 as the base
> address of the internal registers. This information is available in the
> DT. I think you could simply take the base address of the PCIe
> controller, round down to 1 MB (which is the size of the internal
> registers window) and that would give you the right address.

Apparently, the PCIe controller is outside of the internal registers space.

I could try to use a similar code as in
arch/arm/mach-mvebu/pm.c:mvebu_internal_reg_base or get the first child
of "internal-regs" and call of_translate_address on it with one zero cell.

Do you have a better solution?

Thanks,

-- 
- Shmuel Hazan

mailto:sh@tkos.co.il | tel:+972-523-746-435 | http://tkos.co.il

