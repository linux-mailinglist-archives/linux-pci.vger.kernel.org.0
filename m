Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B871124E96
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 18:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfLRRAn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 12:00:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56740 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727440AbfLRRAn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2019 12:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576688442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dn5SUwiPZ6v5NQ8mtwG6iqV/r/5Gbbs8HrzPzH1EerI=;
        b=ItGxrXOflq3XyLIwUJF7tFGtxNAtXEZvoJAqtOQ8q+t4Z7s9krV+q06Ts5M9DKXW1CBzPU
        agL7aGhiuJwVchL9v7JxPXOgWH5wVBcgrqXkEfqei7IugImk2h4LzKrvvEG+ju9FXxeKXT
        Ncvjlv+uMS2lQ3/c1dvaa/IM9Dcdrpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-9UUkOd8SOmCuHuHDl5aHpg-1; Wed, 18 Dec 2019 12:00:18 -0500
X-MC-Unique: 9UUkOd8SOmCuHuHDl5aHpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 797B119586C8;
        Wed, 18 Dec 2019 17:00:14 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A81460C18;
        Wed, 18 Dec 2019 17:00:09 +0000 (UTC)
Subject: Re: [PATCH v3 08/13] iommu/arm-smmu-v3: Propate ssid_bits
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-9-jean-philippe@linaro.org>
 <466bbc57-79d4-274c-67bc-4ed591da9968@redhat.com>
 <20191218160834.GG2371701@myrica>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <bf66e477-6fea-517e-98b6-123eef625334@redhat.com>
Date:   Wed, 18 Dec 2019 18:00:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191218160834.GG2371701@myrica>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 12/18/19 5:08 PM, Jean-Philippe Brucker wrote:
> On Tue, Dec 17, 2019 at 06:07:26PM +0100, Auger Eric wrote:
>> Hi Jean,
>>
>> On 12/9/19 7:05 PM, Jean-Philippe Brucker wrote:
>>
>> s/Propate/Propagate in the commit title.
>>> Now that we support substream IDs, initialize s1cdmax with the number of
>>> SSID bits supported by a master and the SMMU.
>>>
>>> Context descriptor tables are allocated once for the first master
>>> attached to a domain. Therefore attaching multiple devices with
>>> different SSID sizes is tricky, and we currently don't support it.
>>>
>>> As a future improvement it would be nice to at least support attaching a
>>> SSID-capable device to a domain that isn't using SSID, by reallocating
>>> the SSID table.
>> Isn't that use case relevant (I mean using both devices in a non SSID
>> use case). For platform devices you can work this around with FW but for
>> PCI devices?
> 
> Normally each device gets its own domain. Especially since PASID is a PCI
> Express capability, I expect them to be properly isolated with ACS, each
> with its own IOMMU group. So I don't think this is too relevant for the
> moment, it would be a quirk for a broken system.

OK

Eric
> 
> Thanks,
> Jean
> 

