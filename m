Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3DD2F254D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 02:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbhALBMz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 20:12:55 -0500
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:40324 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727236AbhALBMz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2021 20:12:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 03133181D330D;
        Tue, 12 Jan 2021 01:12:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2540:2559:2562:2731:2734:2828:2902:3138:3139:3140:3141:3142:3351:3622:3865:3870:4321:5007:6120:6742:7652:7809:7901:9149:10004:10400:10848:11658:11914:12297:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21451:21627:21939:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:6,LUA_SUMMARY:none
X-HE-Tag: teeth14_590d64827511
X-Filterd-Recvd-Size: 2120
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Jan 2021 01:12:11 +0000 (UTC)
Message-ID: <284e3f48184af93e6826e53d8ec32b569a291c2c.camel@perches.com>
Subject: Re: [RFC PATCH v3 16/16] MAINTAINERS: Add maintainers of the CXL
 driver
From:   Joe Perches <joe@perches.com>
To:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Date:   Mon, 11 Jan 2021 17:12:10 -0800
In-Reply-To: <20210111225121.820014-18-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
         <20210111225121.820014-18-ben.widawsky@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2021-01-11 at 14:51 -0800, Ben Widawsky wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -4459,6 +4459,16 @@ F:	fs/configfs/
>  F:	include/linux/configfs.h
>  F:	samples/configfs/
>  
> +COMPUTE EXPRESS LINK (CXL)
> +M:	Vishal Verma <vishal.l.verma@intel.com>
> +M:	Ira Weiny <ira.weiny@intel.com>
> +M:	Ben Widawsky <ben.widawsky@intel.com>
> +M:	Dan Williams <dan.j.williams@intel.com>
> +L:	linux-cxl@vger.kernel.org
> +S:	Maintained
> +F:	drivers/cxl/
> +F:	include/uapi/linux/cxl_mem.h
> +
>  CONSOLE SUBSYSTEM
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  S:	Supported

Keep the MAINTAINERS entries in alphabetic order please.
Move this section between:

COMPILER ATTRIBUTES
CONEXANT ACCESSRUNNER USB DRIVER

