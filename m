Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 015651625F2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2020 13:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgBRMMO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Feb 2020 07:12:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35234 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgBRMMN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2020 07:12:13 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01ICCBVE043445;
        Tue, 18 Feb 2020 06:12:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582027931;
        bh=3aMDTF0GOs2S7c4YwGJuW9P5RP0Ejeex/uBDewc5seo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GeXS1C2nwbs8Vqql11hEh5wh0WQwcJDr/IOAowLZFtmFvz/OBr7gGvMWVddOOdbh5
         9hCsQp52hH3t4X6gv2tFAaWDzcPli4nJyqsxra0Y/xIkJWqu88gejMQaq8zVDy63o4
         BQn1/A1ipcIHFMt7MuphBDXJ1y80fh4U/pdDCWjY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01ICCBw7113965;
        Tue, 18 Feb 2020 06:12:11 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 18
 Feb 2020 06:12:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 18 Feb 2020 06:12:10 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01ICC9pd023656;
        Tue, 18 Feb 2020 06:12:10 -0600
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com>
 <20200203142155.GA16388@lst.de> <a5eb4f73-418a-6780-354f-175d08395e71@ti.com>
 <20200205074719.GA22701@lst.de> <4a8bf1d3-6f8e-d13e-eae0-4db54f5cab8c@ti.com>
 <20200205084844.GA23831@lst.de> <88d50d13-65c7-7ca3-59c6-56f7d66c3816@ti.com>
 <20200205091959.GA24413@lst.de> <9be3bed4-3804-1b3e-a91a-ed52407524ce@ti.com>
 <20200205160542.GA30981@lst.de> <20200217142333.GA28421@lst.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a7d920ab-b681-45bc-677b-3db76e96cf7c@ti.com>
Date:   Tue, 18 Feb 2020 17:45:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200217142333.GA28421@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Christoph,

On 17/02/20 7:53 pm, Christoph Hellwig wrote:
> On Wed, Feb 05, 2020 at 05:05:42PM +0100, Christoph Hellwig wrote:
>> On Wed, Feb 05, 2020 at 03:03:13PM +0530, Kishon Vijay Abraham I wrote:
>>> Yes, I see the mismatch after reverting the above patches.
>>
>> In which case the data mismatch is very likely due to a different root
>> cause.
> 
> Did you manage to dig into this a little more?

I'll probably get to this later half of this week. Will update you then.

Thanks
Kishon
