Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315EA616639
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 16:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiKBPdo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 11:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKBPdj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 11:33:39 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28A81F60E;
        Wed,  2 Nov 2022 08:33:34 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2F25FC002713;
        Wed, 2 Nov 2022 15:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=GURUunwbIEHWjIMSeeVSXk/3eFsEGc4H3mumzBPrFB0=;
 b=oAggLX3Tqg0IpVOK9w3101MejQGFbtOQrCC06S3mwOmMx5vUC2pF7kwRPtyXfctx9/Ms
 WgJ/1g1iRPknX/ASCdoFbLFx75y3SXOlUo+uFz+rxSwKxA8RvyGFoY50y/ruesWYfCCq
 0/Vc3j2mhLg3Ycmod7Egg3BYlh++GdNzCkJF/IMrlxtpHZQPY7c0xG+p6GS7cTvR92Y4
 7htmV/wvq313/lFePcol5h7rpB9ZjPJMbxuO9GET72CyTw3o7SRX2THl5XC55TJWPrBG
 id7053QTl4NraCSyb6cN7z4fUEmniq5+2A3N2BlhiGJ4l5JHlLZJ/RS45eUK4syF64w+ Cw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kkfs8wv5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 15:33:29 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 095DD8040FF;
        Wed,  2 Nov 2022 15:33:29 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id CA3A2804BD4;
        Wed,  2 Nov 2022 15:33:27 +0000 (UTC)
Date:   Wed, 2 Nov 2022 10:33:25 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Robin Holt <robinmholt@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 16-bit _SEG vs 8 bit PCIe Flit mode Segment
Message-ID: <20221102153325.GA221768@hpe.com>
References: <20221101144905.GA1258094@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101144905.GA1258094@bhelgaas>
X-Proofpoint-GUID: 4AB-RdUpHLN0KUpDl0-X434VfrsYQHNL
X-Proofpoint-ORIG-GUID: 4AB-RdUpHLN0KUpDl0-X434VfrsYQHNL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_13,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=670
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020100
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

Thanks for letting us know about this.

This is just to let you know that, while we are still investigating this,
our UV3 Broadwell era systems do use more than 8 bits for the segment #.

From lscpi on UV3:
  1007:3f:08.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5 v2/Core i7 QPI Link 0 (rev 07)

Dimitri

On Tue, Nov 01, 2022 at 09:49:05AM -0500, Bjorn Helgaas wrote:
> ACPI r6.5, sec 6.5.6, currently says the low 16 bits of _SEG are the
> PCI Segment Group number.  PCIe r6.0, sec 2.2.1.2, added Flit mode
> with TLP headers that may contain an 8-bit Segment number.
> 
> ACPI currently says _SEG is purely a software thing and has no
> connection to any physical entities.  But this may get a little blurry
> when Segment numbers appear in TLPs.  For example, AER header logs
> will likely contain the Flit Segment, and we'll need to correlate that
> with the _SEG-derived identifiers Linux uses.
> 
> One possibility is to reduce the width of _SEG to 8 bits to match the
> Flit mode Segment and require them to be identical.
> 
> I'm trying to figure out whether that would break any existing
> systems.  I've heard rumors that large systems like SGI UV may use
> more than 8 bits of _SEG.  But I don't know any details.
> 
> Bjorn
