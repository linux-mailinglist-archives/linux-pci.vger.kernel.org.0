Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33CCD14508C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2020 10:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgAVJrZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 04:47:25 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:58026 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387704AbgAVJmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jan 2020 04:42:24 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 1CE3C1C0371
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2020 10:42:22 +0100 (CET)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id 4DC531A0561; Wed, 22 Jan 2020 10:42:21 +0100 (CET)
Date:   Wed, 22 Jan 2020 10:42:21 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, jcm@redhat.com,
        nariman.poushin@linaro.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH 0/2] lspci: support for CCIX DVSEC
Message-ID: <mj+md-20200122.092951.48097.albireo@ucw.cz>
References: <20190627144355.27913-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627144355.27913-1-Jonathan.Cameron@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: /
X-Spam-Status: No, score=-0.80
X-Spamd-Result: default: False [-0.80 / 15.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         SENDER_REP_HAM(0.00)[asn: 51744(0.26), country: CZ(-0.00), ip: 91.219.245.20(-0.37)];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         AUTH_NA(1.00)[];
         DMARC_NA(0.00)[ucw.cz];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.926];
         R_SPF_NA(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         TAGGED_FROM(0.00)[f-220120,linux-pci=vger.kernel.org];
         MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 1CE3C1C0371
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> This series adds support for near complete interpretation of CCIX DVSEC.
> Most of the CCIX base 1.0 specification is covered, but a few minor
> elements are not currently printed (some of the timeouts and credit
> types). That can be rectified in a future version or follow up patch
> and isn't necessary for this discussion.
> 
> CCIX (www.ccixconsortium.org) is a coherent interconnect specification.
> It is flexible in allowed interconnect topologies, but is overlayed
> on top of a traditional PCIe tree.  Note that CCIX physical devices
> may turn up in a number of different locations in the PCIe tree.
> 
> The topology configuration and physical layer controls and description
> are presented using PCIe DVSEC structures defined in the CCIX 1.0
> base specification.  These use the unique ID granted by the PCISIG.
> Note that, whilst it looks like a Vendor ID for this usecase it is
> not one and can only be used to identify DVSEC and related CCIX protocol
> messages.
> 
> So why an RFC?
> * Are the lspci maintainers happy to have the tool include support for
>   PCI configuration structures that are defined in other standards?
> * Is the general approach and code structure appropriate?
> * It's a lot of description so chances are some of it isn't in a format
>   consistent with the rest of lspci!

I am very happy to include parsers of vendor-specific capabilities.

The general approach is fine, but please bring the source code closer
to the coding style of the rest of pciutils.

> The following grants the 'pciutils' project trademark usage of
> CCIX tradmark where relevant.
> 
> This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
> you and other parties that are paticipating (the "participants") in the
> pciutils with the understanding that the participants will use CCIX's
> name and trademark only when this patch is used in association with the
> pciutils project.

I suspect that this is not compatible with the GPL. Everybody is allowed
to use portions of pciutils in other GPLed projects. So the trademark usage
right should be granted to use in the contributed code, regardless of whether
it is currently in the pciutils project, or any other project.

> CCIX is also distributing this patch to these participants with the
> understanding that if any portion of the CCIX specification will be
> used or referenced in the pciutils project, the participants will not modify
> the cited portion of the CCIX specification and will give CCIX propery
> copyright attribution by including the following copyright notice with
> the cited part of the CCIX specification:
> "© 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."

Are there any citations affected by this in your patch? You only refer to data
structures defined by the specification, but this is factual information which
cannot be copyrighted (but IANAL).

I am strongly opposed to adding more copyright notices to the pciutils
besides the GPL.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
hAS ANYONE SEEN MY cAPSLOCK KEY?
