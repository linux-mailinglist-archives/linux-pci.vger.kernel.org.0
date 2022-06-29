Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47A560AF7
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 22:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiF2UVV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 16:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiF2UVU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 16:21:20 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2682655C;
        Wed, 29 Jun 2022 13:21:19 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220629202118usoutp029a2fe36a6978904fe7c2aacdfcce3fe9~9MPeouByJ0653306533usoutp02P;
        Wed, 29 Jun 2022 20:21:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220629202118usoutp029a2fe36a6978904fe7c2aacdfcce3fe9~9MPeouByJ0653306533usoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656534078;
        bh=Xa6KQ9lRNGUH1NXlKyrnq3bwVa1PO/sSyuZksalxf5E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=FKMnDUkAgUK4eZdfRqBbIaJ7qYLjU2qXo6MAevyW59Ll/s/mmTclh1MhGMhsQas4+
         6MBc6OQcH23Bv6xaaMVHauIrG+9dpUUQ80LCTnhvr6lFs+5CwrpGud66Ki5/XtGNEq
         pU+8hP0Ne+tfmqS1g1Q8ByOdZ+ZfRVCJNtHyou8Y=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629202117uscas1p22ba9ed315d799355fffa25758c786576~9MPeci01D2612526125uscas1p2c;
        Wed, 29 Jun 2022 20:21:17 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 31.BF.09749.D34BCB26; Wed,
        29 Jun 2022 16:21:17 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220629202117uscas1p2892fb68ae60c4754e2f7d26882a92ae5~9MPeLPf6o0195001950uscas1p2E;
        Wed, 29 Jun 2022 20:21:17 +0000 (GMT)
X-AuditID: cbfec370-a83ff70000002615-fa-62bcb43d0da7
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 61.7A.57470.D34BCB26; Wed,
        29 Jun 2022 16:21:17 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 29 Jun 2022 13:21:16 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        29 Jun 2022 13:21:16 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 05/46] cxl/core: Drop ->platform_res attribute for root
 decoders
Thread-Topic: [PATCH 05/46] cxl/core: Drop ->platform_res attribute for root
        decoders
Thread-Index: AQHYi/XJZNdlvVrhU0SI5d+SQ3FK1Q==
Date:   Wed, 29 Jun 2022 20:21:16 +0000
Message-ID: <20220629202116.GC1140419@bgt-140510-bm01>
In-Reply-To: <165603873619.551046.791596854070136223.stgit@dwillia2-xfh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30230E33D023C744BF3C6C915C6D5B46@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djX87q2W/YkGay8ZGFx9/EFNovpUy8w
        WpyesIjJ4vysUywWZ+cdZ7NY+eMPq8XlE5cYHdg9Nq/Q8li85yWTx4vNMxk9Pm+SC2CJ4rJJ
        Sc3JLEst0rdL4Mp4MuMJS8ETo4oJJ7MbGCdodjFyckgImEjsPtbN0sXIxSEksJJR4snzC6wQ
        TiuTxKN1sxlhquYuO8EMkVjLKHHk13l2COcTo0RPy3qo/mWMEl9/T2MFaWETMJD4fXwjM4gt
        IqAtMXHOQbB2ZoFTTBLff/1kAUkIC4RJbP3SxQhRFC5x/ccfFghbT2L9q2dgg1gEVCX+vGgG
        WsfBwStgJnGhRxgkzCngIbF6322wckYBMYnvp9YwgdjMAuISt57MZ4I4W1Bi0ew9zBC2mMS/
        XQ/ZIGxFifvfX7JD1OtILNj9iQ3CtpPYunQRC4StLbFs4WuwXl6gOSdnPmGB6JWUOLjiBtjD
        EgJXOCRWv90IlXCRuHnnFNQyaYm/d5cxQRS1M0p8mLCPFcKZwChx5+1PqDOsJf51XmOfwKgy
        C8nls5BcNQvJVbOQXDULyVULGFlXMYqXFhfnpqcWG+ellusVJ+YWl+al6yXn525iBCam0/8O
        F+xgvHXro94hRiYOxkOMEhzMSiK8C8/sTBLiTUmsrEotyo8vKs1JLT7EKM3BoiTOuyxzQ6KQ
        QHpiSWp2ampBahFMlomDU6qBqShz39vX7Bfu2qrMXilQuV8lxdyuRELFMPdJUJz6vM/rJrDm
        1UXyhmrmFN7ek7BS0edr5dMrJ2OMt2/P2KO+vzIq3Vh5RtClgnv1zaYhlfaTL9btda2Jvr5O
        WMu5c0LsKX2FtNmLa28w+K4rXXbY4Hfuw3SblebXRWp5mha/kjg9KSR7U0jPqkANpa6VtkeW
        Jlya+vfwtrqvF0++THhb8uVJvbXBnkL2JzYbjF8fyvp0xK1+8gz/3Ktp1na3JG9svM1mUD29
        WWjDlzs99p+lsh7M+3l+HsetOs1tZTVigd0nVjTP8HZ7NqlayakoRu6WxI7JPH9r/383vbP+
        xCffr/9O7uetXPubxTsplyW2WImlOCPRUIu5qDgRAA/quVW7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWS2cA0Sdd2y54kg8arShZ3H19gs5g+9QKj
        xekJi5gszs86xWJxdt5xNouVP/6wWlw+cYnRgd1j8wotj8V7XjJ5vNg8k9Hj8ya5AJYoLpuU
        1JzMstQifbsErownM56wFDwxqphwMruBcYJmFyMnh4SAicTcZSeYuxi5OIQEVjNKTDw4A8r5
        xCix7N5hJghnGaPElm2vmEBa2AQMJH4f38gMYosIaEtMnHMQrINZ4BSTxPdfP1lAEsICYRJb
        v3QxQhSFS3ydNo8NwtaTWP/qGSuIzSKgKvHnRTN7FyMHB6+AmcSFHmGIZW2MEtcfd4LVcwp4
        SKzedxtsJqOAmMT3U2vAjmAWEJe49WQ+E8QPAhJL9pxnhrBFJV4+/scKYStK3P/+kh2iXkdi
        we5PbBC2ncTWpYtYIGxtiWULX4P18goISpyc+YQFoldS4uCKGywTGCVmIVk3C8moWUhGzUIy
        ahaSUQsYWVcxipcWF+emVxQb5aWW6xUn5haX5qXrJefnbmIERvTpf4ejdzDevvVR7xAjEwfj
        IUYJDmYlEd6FZ3YmCfGmJFZWpRblxxeV5qQWH2KU5mBREud9GTUxXkggPbEkNTs1tSC1CCbL
        xMEp1cBkFsr5t73oVKEZwxfWV48N2r2zIsNbTPP8Pppffm10THme5ISbk0t6baYs4TSbsDxr
        avjOlBK7PUleEVyTpkXZiHY7ixybX508d+KPIEexvnebI1ROX2p/3Hdiyldx05VPAgScy4SX
        G71vn2R1dZbcghV2/jP/vqrYY/SoaNUzhj9hwpIG8of3KO2Z0SXL9/Ogim988r19d4w1thjq
        9If3qr/qN8x3kzdLtnf5LPvO94RJ4X9e95fqx/OmG346xLS58OBNxUnf/FakeUifiK3/ZmVm
        vzWn+J3guo2v++zt9F7sC2g7LMT8NvvQxa2FJ776vSyImhv/meNRSeyTlqzzDBZtshtmsDgd
        dt49+bYSS3FGoqEWc1FxIgB8lOjjVwMAAA==
X-CMS-MailID: 20220629202117uscas1p2892fb68ae60c4754e2f7d26882a92ae5
CMS-TYPE: 301P
X-CMS-RootMailID: 20220629202117uscas1p2892fb68ae60c4754e2f7d26882a92ae5
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603873619.551046.791596854070136223.stgit@dwillia2-xfh>
        <CGME20220629202117uscas1p2892fb68ae60c4754e2f7d26882a92ae5@uscas1p2.samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 07:45:36PM -0700, Dan Williams wrote:
> Root decoders are responsible for hosting the available host address
> space for endpoints and regions to claim. The tracking of that available
> capacity can be done in iomem_resource directly. As a result, root
> decoders no longer need to host their own resource tree. The
> current ->platform_res attribute was added prematurely.
>=20
> Otherwise, ->hpa_range fills the role of conveying the current decode
> range of the decoder.
>=20
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/acpi.c      |   17 ++++++++++-------
>  drivers/cxl/core/pci.c  |    8 +-------
>  drivers/cxl/core/port.c |   30 +++++++-----------------------
>  drivers/cxl/cxl.h       |    6 +-----
>  4 files changed, 19 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 40286f5df812..951695cdb455 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -108,8 +108,10 @@ static int cxl_parse_cfmws(union acpi_subtable_heade=
rs *header, void *arg,
> =20
>  	cxld->flags =3D cfmws_to_decoder_flags(cfmws->restrictions);
>  	cxld->target_type =3D CXL_DECODER_EXPANDER;
> -	cxld->platform_res =3D (struct resource)DEFINE_RES_MEM(cfmws->base_hpa,
> -							     cfmws->window_size);
> +	cxld->hpa_range =3D (struct range) {
> +		.start =3D cfmws->base_hpa,
> +		.end =3D cfmws->base_hpa + cfmws->window_size - 1,
> +	};
>  	cxld->interleave_ways =3D CFMWS_INTERLEAVE_WAYS(cfmws);
>  	cxld->interleave_granularity =3D CFMWS_INTERLEAVE_GRANULARITY(cfmws);
> =20
> @@ -119,13 +121,14 @@ static int cxl_parse_cfmws(union acpi_subtable_head=
ers *header, void *arg,
>  	else
>  		rc =3D cxl_decoder_autoremove(dev, cxld);
>  	if (rc) {
> -		dev_err(dev, "Failed to add decoder for %pr\n",
> -			&cxld->platform_res);
> +		dev_err(dev, "Failed to add decoder for [%#llx - %#llx]\n",
> +			cxld->hpa_range.start, cxld->hpa_range.end);

Minor nit, should we add range in our debug message?

+		dev_err(dev, "Failed to add decoder for range [%#llx - %#llx]\n",

>  		return 0;
>  	}
> -	dev_dbg(dev, "add: %s node: %d range %pr\n", dev_name(&cxld->dev),
> -		phys_to_target_node(cxld->platform_res.start),
> -		&cxld->platform_res);
> +	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
> +		dev_name(&cxld->dev),
> +		phys_to_target_node(cxld->hpa_range.start),
> +		cxld->hpa_range.start, cxld->hpa_range.end);
> =20
>  	return 0;
>  }
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c4c99ff7b55e..7672789c3225 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -225,7 +225,6 @@ static int dvsec_range_allowed(struct device *dev, vo=
id *arg)
>  {
>  	struct range *dev_range =3D arg;
>  	struct cxl_decoder *cxld;
> -	struct range root_range;
> =20
>  	if (!is_root_decoder(dev))
>  		return 0;
> @@ -237,12 +236,7 @@ static int dvsec_range_allowed(struct device *dev, v=
oid *arg)
>  	if (!(cxld->flags & CXL_DECODER_F_RAM))
>  		return 0;
> =20
> -	root_range =3D (struct range) {
> -		.start =3D cxld->platform_res.start,
> -		.end =3D cxld->platform_res.end,
> -	};
> -
> -	return range_contains(&root_range, dev_range);
> +	return range_contains(&cxld->hpa_range, dev_range);
>  }
> =20
>  static void disable_hdm(void *_cxlhdm)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 98bcbbd59a75..b51eb41aa839 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -73,29 +73,17 @@ static ssize_t start_show(struct device *dev, struct =
device_attribute *attr,
>  			  char *buf)
>  {
>  	struct cxl_decoder *cxld =3D to_cxl_decoder(dev);
> -	u64 start;
> =20
> -	if (is_root_decoder(dev))
> -		start =3D cxld->platform_res.start;
> -	else
> -		start =3D cxld->hpa_range.start;
> -
> -	return sysfs_emit(buf, "%#llx\n", start);
> +	return sysfs_emit(buf, "%#llx\n", cxld->hpa_range.start);
>  }
>  static DEVICE_ATTR_ADMIN_RO(start);
> =20
>  static ssize_t size_show(struct device *dev, struct device_attribute *at=
tr,
> -			char *buf)
> +			 char *buf)
>  {
>  	struct cxl_decoder *cxld =3D to_cxl_decoder(dev);
> -	u64 size;
> -
> -	if (is_root_decoder(dev))
> -		size =3D resource_size(&cxld->platform_res);
> -	else
> -		size =3D range_len(&cxld->hpa_range);
> =20
> -	return sysfs_emit(buf, "%#llx\n", size);
> +	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->hpa_range));
>  }
>  static DEVICE_ATTR_RO(size);
> =20
> @@ -1233,7 +1221,10 @@ static struct cxl_decoder *cxl_decoder_alloc(struc=
t cxl_port *port,
>  	cxld->interleave_ways =3D 1;
>  	cxld->interleave_granularity =3D PAGE_SIZE;
>  	cxld->target_type =3D CXL_DECODER_EXPANDER;
> -	cxld->platform_res =3D (struct resource)DEFINE_RES_MEM(0, 0);
> +	cxld->hpa_range =3D (struct range) {
> +		.start =3D 0,
> +		.end =3D -1,
> +	};
> =20
>  	return cxld;
>  err:
> @@ -1347,13 +1338,6 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxl=
d, int *target_map)
>  	if (rc)
>  		return rc;
> =20
> -	/*
> -	 * Platform decoder resources should show up with a reasonable name. Al=
l
> -	 * other resources are just sub ranges within the main decoder resource=
.
> -	 */
> -	if (is_root_decoder(dev))
> -		cxld->platform_res.name =3D dev_name(dev);
> -
>  	return device_add(dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_decoder_add_locked, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 8256728cea8d..35ce17872fc1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -197,7 +197,6 @@ enum cxl_decoder_type {
>   * struct cxl_decoder - CXL address range decode configuration
>   * @dev: this decoder's device
>   * @id: kernel device name id
> - * @platform_res: address space resources considered by root decoder
>   * @hpa_range: Host physical address range mapped by this decoder
>   * @interleave_ways: number of cxl_dports in this decode
>   * @interleave_granularity: data stride per dport
> @@ -210,10 +209,7 @@ enum cxl_decoder_type {
>  struct cxl_decoder {
>  	struct device dev;
>  	int id;
> -	union {
> -		struct resource platform_res;
> -		struct range hpa_range;
> -	};
> +	struct range hpa_range;
>  	int interleave_ways;
>  	int interleave_granularity;
>  	enum cxl_decoder_type target_type;
>=20
>=20


Otherwise, looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
