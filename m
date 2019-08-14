Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A898DCD1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 20:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfHNSRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 14:17:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNSRM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2019 14:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6JYuNbXTEY0JKWYAqaGAimiaYT0VjQUQqOk3MXDEf9A=; b=PE7I31dLfJ6mu8sswFdLrgXSZ
        vNCd+KrMUK2+pNLDrt44FzBZZ+45QE3XoyQ2Jq2c07B67FfkrzOkHEq6nYROYbySC3+EQjcAzbi0H
        7zit1QOfEjzNaPbJWaMs+MwDqIWxtLYBo4ir+d4QiRkEgGnBTtEXgCgFKxdJDzDnTk5RdtMvXa2Ag
        b/dotKxJMKgcUudv54iJVYZMisSEEs7amTtpkKuUTPQrZZjk1gGYFXEKTgczZpoqmhEiQfgRIm9Lh
        ETnYP3Wf4eZgdTUOpH3lcm+KrhuqfNaZewFaby2H5no50xOnqwE5ZMgX575fqmhDPNlZffZPpgQVZ
        HO4CsuVkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxxpf-0004XD-1x; Wed, 14 Aug 2019 18:17:11 +0000
Date:   Wed, 14 Aug 2019 11:17:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daire McNamara <daire.mcnamara@microchip.com>
Cc:     linux-pci@vger.kernel.org, ivan.griffin@emdalo.com,
        cyril.jean@microchip.com
Subject: Re: [PATCH] Add Microchip/Microsemi PolarFire-SoC PCIe support
Message-ID: <20190814181710.GA17336@infradead.org>
References: <20190206155641.GA1540@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206155641.GA1540@microchip.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Daire,

did you manage to find some time to incorporate the comments and
prepare a new version?
