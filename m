Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB22184F3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 12:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgGHKbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 06:31:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37592 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgGHKbe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 06:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594204293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrI1hosUW/BsvNKmGHNqnVff2XUsxG3jfw7rZBHv2N0=;
        b=K0a3zhP76yYKYb2R4wLAt1Cruz5CS4FyzW1m3WG1YJH17xkug+nQkCbBO/7CMBZEykq/zq
        VH4GDRESrfkdFpEPD4FCqO/UaIMZBsp+NqtgGAXNy/zz/wepZ3b8WsaWacW+q5TJ/jM9kg
        /M2XPRLGeMpJtmQbGDC0x/OuIt8lCgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-99BAmU-SMoOjjSl1JetzOQ-1; Wed, 08 Jul 2020 06:31:29 -0400
X-MC-Unique: 99BAmU-SMoOjjSl1JetzOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DD21107ACCA;
        Wed,  8 Jul 2020 10:31:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com [10.36.112.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA9D87847C;
        Wed,  8 Jul 2020 10:31:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id F2EC616E18; Wed,  8 Jul 2020 12:31:25 +0200 (CEST)
Date:   Wed, 8 Jul 2020 12:31:25 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] PCI: Move PCI_VENDOR_ID_REDHAT definition to pci_ids.h
Message-ID: <20200708103125.eqjadusbxx33n45k@sirius.home.kraxel.org>
References: <1594195170-11119-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594195170-11119-1-git-send-email-chenhc@lemote.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 08, 2020 at 03:59:30PM +0800, Huacai Chen wrote:
> Instead of duplicating the PCI_VENDOR_ID_REDHAT definition everywhere,
> move it to include/linux/pci_ids.h is better.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

